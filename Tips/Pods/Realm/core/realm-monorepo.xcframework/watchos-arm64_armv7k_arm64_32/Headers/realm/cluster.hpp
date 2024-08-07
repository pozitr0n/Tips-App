/*************************************************************************
 *
 * Copyright 2016 Realm Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 **************************************************************************/

#ifndef REALM_CLUSTER_HPP
#define REALM_CLUSTER_HPP

#include <realm/keys.hpp>
#include <realm/mixed.hpp>
#include <realm/array.hpp>
#include <realm/array_unsigned.hpp>
#include <realm/data_type.hpp>
#include <realm/column_type_traits.hpp>

namespace realm {

class Spec;
class Table;
class Obj;
class Cluster;
class ClusterNodeInner;
class ClusterTree;
class ColumnAttrMask;
class CascadeState;

struct FieldValue {
    FieldValue(ColKey k, Mixed val, bool is_default = false) noexcept
        : col_key(k)
        , value(val)
        , is_default(is_default)
    {
    }
    ColKey col_key;
    Mixed value;
    bool is_default;
};

class FieldValues {
public:
    FieldValues() {}
    FieldValues(std::initializer_list<FieldValue>);
    void insert(ColKey k, Mixed val, bool is_default = false);
    auto begin() const noexcept
    {
        return m_values.begin();
    }
    auto end() const noexcept
    {
        return m_values.end();
    }
    auto begin() noexcept
    {
        return m_values.begin();
    }
    auto end() noexcept
    {
        return m_values.end();
    }

private:
    std::vector<FieldValue> m_values;
};

class ClusterNode : public Array {
public:
    struct RowKey {
        RowKey()
            : value(-1)
        {
        }
        RowKey(uint64_t v)
            : value(v)
        {
        }
        explicit RowKey(ObjKey k)
            : value(k.value)
        {
        }
        uint64_t value;
    };
    // This structure is used to bring information back to the upper nodes when
    // inserting new objects or finding existing ones.
    struct State {
        int64_t split_key;          // When a node is split, this variable holds the value of the
                                    // first key in the new node. (Relative to the key offset)
        MemRef mem;                 // MemRef to the Cluster holding the new/found object
        size_t index = realm::npos; // The index within the Cluster at which the object is stored.

        operator bool() const
        {
            return index != realm::npos;
        }
    };

    struct IteratorState {
        IteratorState(Cluster& leaf)
            : m_current_leaf(leaf)
        {
        }
        IteratorState(const IteratorState&);
        void clear();
        void init(State&, ObjKey);

        Cluster& m_current_leaf;
        int64_t m_key_offset = 0;
        size_t m_current_index = 0;
    };

    ClusterNode(uint64_t offset, Allocator& allocator, const ClusterTree& tree_top)
        : Array(allocator)
        , m_tree_top(tree_top)
        , m_keys(allocator)
        , m_offset(offset)
    {
        m_keys.set_parent(this, 0);
    }
    virtual ~ClusterNode() {}
    void init_from_parent()
    {
        ref_type ref = get_ref_from_parent();
        char* header = m_alloc.translate(ref);
        init(MemRef(header, ref, m_alloc));
    }
    int64_t get_key_value(size_t ndx) const
    {
        return m_keys.get(ndx);
    }

    const Table* get_owning_table() const noexcept;

    virtual void update_from_parent() noexcept = 0;
    virtual bool is_leaf() const = 0;
    virtual int get_sub_tree_depth() const = 0;
    virtual size_t node_size() const = 0;
    /// Number of elements in this subtree
    virtual size_t get_tree_size() const = 0;
    /// Last key in this subtree
    virtual int64_t get_last_key_value() const = 0;
    virtual void ensure_general_form() = 0;

    /// Initialize node from 'mem'
    virtual void init(MemRef mem) = 0;
    /// Descend the tree from the root and copy-on-write the leaf
    /// This will update all parents accordingly
    virtual MemRef ensure_writeable(RowKey k) = 0;
    /// A leaf cluster has got a new ref. Descend the tree from the root,
    /// find the leaf and update the ref in the parent node
    virtual void update_ref_in_parent(RowKey k, ref_type ref) = 0;

    /// Init and potentially Insert a column
    virtual void insert_column(ColKey col) = 0;
    /// Clear and potentially Remove a column
    virtual void remove_column(ColKey col) = 0;
    /// Return number of columns created. To be used by upgrade logic
    virtual size_t nb_columns() const
    {
        return realm::npos;
    }
    /// Create a new object identified by 'key' and update 'state' accordingly
    /// Return reference to new node created (if any)
    virtual ref_type insert(RowKey k, const FieldValues& init_values, State& state) = 0;
    /// Locate object identified by 'key' and update 'state' accordingly
    void get(ObjKey key, State& state) const;
    /// Locate object identified by 'key' and update 'state' accordingly
    /// Returns `false` if the object doesn't not exist.
    virtual bool try_get(RowKey key, State& state) const noexcept = 0;
    /// Locate object identified by 'ndx' and update 'state' accordingly
    virtual ObjKey get(size_t ndx, State& state) const = 0;
    /// Return the index at which key is stored
    virtual size_t get_ndx(RowKey key, size_t ndx) const noexcept = 0;

    /// Erase element identified by 'key'
    virtual size_t erase(RowKey key, CascadeState& state) = 0;

    /// Nullify links pointing to element identified by 'key'
    virtual void nullify_incoming_links(RowKey key, CascadeState& state) = 0;

    /// Move elements from position 'ndx' to 'new_node'. The new node is supposed
    /// to be a sibling positioned right after this one. All key values must
    /// be subtracted 'key_adj'
    virtual void move(size_t ndx, ClusterNode* new_leaf, int64_t key_adj) = 0;

    virtual void dump_objects(int64_t key_offset, std::string lead) const = 0;

    ObjKey get_real_key(size_t ndx) const
    {
        return ObjKey(get_key_value(ndx) + m_offset);
    }
    const ArrayUnsigned* get_key_array() const
    {
        return m_keys.is_attached() ? &m_keys : nullptr;
    }
    void set_offset(uint64_t offs)
    {
        m_offset = offs;
    }
    uint64_t get_offset() const
    {
        return m_offset;
    }

protected:
#if REALM_MAX_BPNODE_SIZE > 256
    static constexpr int node_shift_factor = 8;
#else
    static constexpr int node_shift_factor = 2;
#endif

    static constexpr size_t cluster_node_size = 1 << node_shift_factor;

    class ClusterKeyArray : public ArrayUnsigned {
    public:
        using ArrayUnsigned::ArrayUnsigned;

        uint64_t get(size_t ndx) const
        {
            return (m_data != nullptr) ? ArrayUnsigned::get(ndx) : uint64_t(ndx);
        }
    };

    const ClusterTree& m_tree_top;
    ClusterKeyArray m_keys;
    uint64_t m_offset;
};

class Cluster : public ClusterNode {
public:
    Cluster(uint64_t offset, Allocator& allocator, const ClusterTree& tree_top)
        : ClusterNode(offset, allocator, tree_top)
    {
    }
    ~Cluster() override;

    static MemRef create_empty_cluster(Allocator& alloc);

    void create(); // Note: leaf columns - may include holes
    void init(MemRef mem) override;
    void update_from_parent() noexcept override;

    bool is_writeable() const
    {
        return !Array::is_read_only();
    }
    MemRef ensure_writeable(RowKey k) override;
    void update_ref_in_parent(RowKey, ref_type ref) override;

    bool is_leaf() const override
    {
        return true;
    }
    int get_sub_tree_depth() const override
    {
        return 0;
    }
    static size_t node_size_from_header(Allocator& alloc, const char* header);
    size_t node_size() const override
    {
        if (!is_attached()) {
            return 0;
        }
        return m_keys.is_attached() ? m_keys.size() : get_size_in_compact_form();
    }
    size_t get_tree_size() const override
    {
        return node_size();
    }
    int64_t get_last_key_value() const override
    {
        auto sz = node_size();
        return sz ? get_key_value(sz - 1) : -1;
    }
    size_t lower_bound_key(RowKey key) const
    {
        if (m_keys.is_attached()) {
            return m_keys.lower_bound(key.value);
        }
        size_t sz = size_t(Array::get(0)) >> 1;
        return key.value > sz ? sz : size_t(key.value);
    }

    void adjust_keys(int64_t offset)
    {
        ensure_general_form();
        m_keys.adjust(0, m_keys.size(), offset);
    }

    ColKey get_col_key(size_t ndx_in_parent) const;

    void ensure_general_form() override;
    void insert_column(ColKey col) override; // Does not move columns!
    void remove_column(ColKey col) override; // Does not move columns - may leave a 'hole'
    size_t nb_columns() const override
    {
        return size() - s_first_col_index;
    }
    ref_type insert(RowKey k, const FieldValues& init_values, State& state) override;
    bool try_get(RowKey k, State& state) const noexcept override;
    ObjKey get(size_t, State& state) const override;
    size_t get_ndx(RowKey key, size_t ndx) const noexcept override;
    size_t erase(RowKey k, CascadeState& state) override;
    void nullify_incoming_links(RowKey key, CascadeState& state) override;
    void upgrade_string_to_enum(ColKey col, ArrayString& keys);

    void init_leaf(ColKey col, ArrayPayload* leaf) const;
    void add_leaf(ColKey col, ref_type ref);

    void verify() const;
    void dump_objects(int64_t key_offset, std::string lead) const override;
    static void remove_backlinks(const Table* origin_table, ObjKey origin_key, ColKey col,
                                 const std::vector<ObjKey>& keys, CascadeState& state);
    static void remove_backlinks(const Table* origin_table, ObjKey origin_key, ColKey col,
                                 const std::vector<ObjLink>& links, CascadeState& state);

private:
    friend class ClusterTree;

    static constexpr size_t s_key_ref_or_size_index = 0;
    static constexpr size_t s_first_col_index = 1;

    size_t get_size_in_compact_form() const
    {
        return size_t(Array::get(s_key_ref_or_size_index)) >> 1; // Size is stored as tagged value
    }
    void insert_row(size_t ndx, RowKey k, const FieldValues& init_values);
    void move(size_t ndx, ClusterNode* new_node, int64_t key_adj) override;
    template <class T>
    void do_create(ColKey col);
    template <class T>
    void do_insert_column(ColKey col, bool nullable);
    template <class T>
    void do_insert_row(size_t ndx, ColKey col, Mixed init_val, bool nullable);
    template <class T>
    void do_move(size_t ndx, ColKey col, Cluster* to);
    template <class T>
    void do_erase(size_t ndx, ColKey col);
    void do_remove_backlinks(ObjKey origin_key, ColKey col, const std::vector<ObjKey>& keys,
                             CascadeState& state) const
    {
        remove_backlinks(get_owning_table(), origin_key, col, keys, state);
    }
    void do_remove_backlinks(ObjKey origin_key, ColKey col, const std::vector<ObjLink>& links,
                             CascadeState& state) const
    {
        remove_backlinks(get_owning_table(), origin_key, col, links, state);
    }
    void do_erase_key(size_t ndx, ColKey col, CascadeState& state);
    void do_erase_mixed(size_t ndx, ColKey col, CascadeState& state);
    void do_insert_key(size_t ndx, ColKey col, Mixed init_val, ObjKey origin_key);
    void do_insert_link(size_t ndx, ColKey col, Mixed init_val, ObjKey origin_key);
    void do_insert_mixed(size_t ndx, ColKey col_key, Mixed init_value, ObjKey origin_key);
    template <class T>
    void set_spec(T&, ColKey::Idx) const;
    template <class ArrayType>
    void verify(ref_type ref, size_t index, util::Optional<size_t>& sz) const;
};

} // namespace realm

#endif /* SRC_REALM_CLUSTER_HPP_ */
