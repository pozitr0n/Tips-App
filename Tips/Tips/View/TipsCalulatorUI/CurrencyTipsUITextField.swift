//
//  CurrencyTipsUITextField.swift
//  Tips
//
//  Created by Raman Kozar on 18/05/2024.
//

import Foundation
import UIKit
import SwiftUI

class CurrencyTipsUITextField: UITextField {
    
    @Binding private var value: Int
    private let formatter: FormatterNumberProtocol

    init(formatter: FormatterNumberProtocol, value: Binding<Int>) {
        
        self.formatter = formatter
        self._value = value
        super.init(frame: .zero)
        
        setupViews()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toSuperview newSuperview: UIView?) {
       
        super.willMove(toSuperview: superview)
        
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(resetSelection), for: .allTouchEvents)
        
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
        
    }

    override func removeFromSuperview() { }

    override func deleteBackward() {
        
        text = textValue.digits.dropLast().string
        sendActions(for: .editingChanged)
        
    }
    
    private func setupViews() {
        
        tintColor = .clear
        font = .systemFont(ofSize: 30, weight: .regular)
        
        setInitialValue()
        
    }
    
    private func setInitialValue() {
        
        if value > 0 {
           
            let currentValue = Double(value)
            let currentDecimalValue = Decimal(currentValue / 100.0)
            
            text = currency(from: currentDecimalValue)
    
        }
        
    }

    @objc private func editingChanged() {
    
        text = currency(from: decimal)

        resetSelection()
        updateValue()
        
    }

    @objc private func resetSelection() {
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }

    private func updateValue() {
        
        DispatchQueue.main.async { [weak self] in
            self?.value = self?.intValue ?? 0
        }
        
    }

    private var textValue: String {
        return text ?? ""
    }

    private var decimal: Decimal {
        return textValue.decimal / pow(10, formatter.maximumFractionDigits)
    }

    private var intValue: Int {
        return NSDecimalNumber(decimal: decimal * 100).intValue
    }

    private func currency(from decimal: Decimal) -> String {
        return formatter.string(for: decimal) ?? ""
    }
    
}
