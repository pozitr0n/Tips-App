//
//  CurrencyCodes.swift
//  Tips
//
//  Created by Raman Kozar on 25/03/2024.
//

import SwiftUI

struct CurrencyCodes: View {
    
    @State private var selectedCurrency = CurrentCurrency.shared.currentCurrency
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
                        
                        let currSymbol = String(describing: getSymbol(forCurrencyCode: currencyCode))
                        
                        if currencyCode != currSymbol
                            && !currSymbol.isEmpty {
                            
                            Text("\(currencyCode) (\(currSymbol))")
                                .tag(currencyCode)
                            
                        } else {
                            
                            Text("\(currencyCode)")
                                .tag(currencyCode)
                            
                        }
                        
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
                
                Button("Choose-Currency.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)) {
                    
                    showDetails.toggle()
                    
                    if showDetails {
                        
                        Currencies().setCurrentCurrency(currentCode: selectedCurrency)
                        
                        guard let defaultCurrentLocale = MappingCurrencyToRegion.locales(currencyCode: CurrentCurrency.shared.currentCurrency).first else {
                            return
                        }
                        
                        CurrentLocales().setCurrentLocale(currentLocale: defaultCurrentLocale)
                        dismiss()
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(-15)
    
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
    
    func getSymbol(forCurrencyCode code: String) -> String {
        
        let locale = NSLocale(localeIdentifier: code)
        
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            
            guard let _newlocale = newlocale.displayName(forKey: .currencySymbol, value: code) else {
                return ""
            }
            
            return _newlocale
            
        }
        
        guard let _newlocale = locale.displayName(forKey: .currencySymbol, value: code) else {
            return ""
        }
        
        return _newlocale
        
    }
    
}

#Preview {
    SettingsSwiftUIView()
}
