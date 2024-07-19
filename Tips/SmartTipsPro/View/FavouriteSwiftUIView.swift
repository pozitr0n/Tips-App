//
//  FavouriteSwiftUIView.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 12/03/2024.
//

import SwiftUI
import RealmSwift

struct FavouriteSwiftUIView: View {
    
    @ObservedResults(TipsModelObject.self) var myFavouriteTips
    @State private var searchText = ""
    
    var body: some View {
        
        if myFavouriteTips.isEmpty {
      
            NavigationView {
                
                Group {
                
                    VStack {
                    
                        Text("Favourite-start".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                            .frame(width: 300, height: 150, alignment: .center)
                            .padding([.leading, .trailing], 10)
                            .background(.guideBackground)
                            .foregroundStyle(.textButtonColorBackground)
                            .multilineTextAlignment(.center)
                            .bold()
                            .font(.system(size: 19))
                            .clipShape(.rect(cornerRadius: 20))
                            .opacity(0.6)

                    }
                    
                }
                .navigationTitle("Favourite.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                
            }
            
        } else {
            
            NavigationView {
                
                VStack {
                    
                    SearchBar(text: $searchText, placeholder: "Search-Text".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                        .padding(.horizontal)
                    
                    // create List + array
                    List {
                        
                        ForEach(filteredTips) { tip in
                            
                            NavigationLink(destination: DetailScreen(favouriteItem: tip)) {
                                
                                VStack {
                                    Text(tip.idDateString)
                                        .padding(.trailing)
                                }
                                
                            }
                            
                        }
                        .onDelete(perform: deleteItems)
                        
                    }
                    .navigationBarTitle("Favourite.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                    
                }
                
            }
            
        }
    
    }
    
    var filteredTips: Results<TipsModelObject> {
        
        if searchText.isEmpty {
            return myFavouriteTips
        } else {
            return myFavouriteTips.filter("tipDate CONTAINS[c] %@", searchText)
        }
        
    }
    
    private func deleteItems(at offsets: IndexSet) {
        TipsModel().deleteTipsInfoFromFavourite(offsets, myFavouriteTips)
    }
    
}

// SearchBar component to use for search functionality
struct SearchBar: View {
    
    @Binding var text: String
    var placeholder: String

    var body: some View {
        
        HStack {
            
            TextField(placeholder, text: $text)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, -5)
            
        }
        
    }
    
}

struct DetailScreen: View {
    
    let favouriteItem: TipsModelObject
    
    var body: some View {
     
        VStack(alignment: .center) {
            
            Spacer()
            
            HStack {
                Text("💵 " + "Operation-At".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) + (favouriteItem.tipDate))
                    .font(.title3)
                    .bold()
            }
            
            VStack(spacing: 1.0) {
            
                HStack(spacing: 1.0) {
                    
                    Text(Localize(key: "sMR-W3-hJp.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipBill)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack(spacing: 1.0) {
                    
                    Text(Localize(key: "DYB-h6-QW8.title", comment: "") + " (\(String(format: "%.0f", favouriteItem.tipPercent))%)")
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipTips)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack(spacing: 1.0) {
                    
                    Text(Localize(key: "gl0-kh-bjo.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipTotal)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack(spacing: 1.0) {
                    
                    Text(Localize(key: "1EH-gv-upV.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text(String(favouriteItem.tipPeople))
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                HStack(spacing: 1.0) {
                    
                    Text(Localize(key: "qeQ-Lf-lwt.title", comment: ""))
                        .font(.body.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    Text("\(String(format: "%0.2f", favouriteItem.tipEachPay)) \(favouriteItem.tipCurrency)")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(.labelBackground)
                        .foregroundStyle(.textButtonColorBackground)
                        .cornerRadius(8)
                    
                }
                .padding(.horizontal)
                
                Text("Favourite-Description".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                    .font(.subheadline)
                    .padding(.top, 10)
                
                HStack {
                
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable().renderingMode(.original).frame(width: 30, height: 30, alignment: .leading)
                    
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,
                                                                                               lineWidth: 2))
                    
                    Text("Saved by Tips")
                        .font(.subheadline)
                    
                }
                .padding(.top, 10)
                     
            }
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(favouriteItem.idDateString), displayMode: .inline)

    }
    
}

struct FavouriteObject: Identifiable {
    
    let id = UUID()
    let idDateString: String
    let tipDate: String
    let tipCurrency: String
    let tipBill: Double
    let tipPercent: Double
    let tipTips: Double
    let tipTotal: Double
    let tipPeople: Int
    let tipEachPay: Double
    
}

#Preview {
    
    FavouriteSwiftUIView()
    
        .environment(\.realmConfiguration, Realm.preview.configuration)
        .onAppear {
            
            let realm = Realm.preview
            try? realm.write {
                
                realm.deleteAll()
                
                let tip = TipsModelObject()
                
                tip.idDateString = "2023-07-12"
                tip.tipDate = "2023-07-12"
                tip.tipCurrency = "PLN"
                tip.tipBill = 100.0
                tip.tipPercent = 10.0
                tip.tipTips = 10.0
                tip.tipTotal = 110.0
                tip.tipPeople = 2
                tip.tipEachPay = 55.0
                
                realm.add(tip)
                
            }
        }
    
}
