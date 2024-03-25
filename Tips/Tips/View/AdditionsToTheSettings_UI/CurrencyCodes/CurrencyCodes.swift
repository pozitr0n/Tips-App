//
//  CurrencyCodes.swift
//  Tips
//
//  Created by Raman Kozar on 25/03/2024.
//

import SwiftUI

struct CurrencyCodes: View {
    
    @State private var selectedCurrency = "PLN"
    @State private var showDetails = false
    @Environment(\.dismiss) var dismiss
    
    let availableCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }.uniqued()
    }()
    
    var body: some View {
                
        VStack() {
        
            Form {
  
                Picker("Select Currency", selection: $selectedCurrency) {
                    ForEach(availableCurrencies, id: \.self) { currencyCode in
                        Text("\(currencyCode)")
                            .tag(currencyCode)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("\(currencyName(currencyCode: selectedCurrency))")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 14))
                
            }
            .frame(height: 340)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            Group {
                
                Button("Choose") {
                    
                    showDetails.toggle()
                    
                    if showDetails {
                        
                        // main logic: saving the currency to the user defaults!!!
                        dismiss()
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(-20)
    
            }
    
        }
        // Maximum height = 390
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 390)
        .background(.modeBG)
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal, 15)
        
    }
    
    func currencyName(currencyCode: String) -> String {
        
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))
        let buffName = locale.localizedString(forCurrencyCode: currencyCode) ?? currencyCode
        
        return buffName == currencyCode ? buffName : buffName.capitalizingFirstLetter()
        
    }
    
}

#Preview {
    SettingsSwiftUIView()
}
