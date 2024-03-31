//
//  Currencies.swift
//  Tips
//
//  Created by Raman Kozar on 31/03/2024.
//

import Foundation

class CurrentCurrency {
    
    static let shared = CurrentCurrency()
    
    // Saving/getting using User Defaults
    var currentCurrency = ""
    
    private init () {}
    
}

final class Currencies {
    
    func getDefaultCurrencyByLocale() -> String {
        
        let locale = Locale.current
        
        guard let currency = locale.currency else {
            return "PLN"
        }
        
        return currency.identifier
        
    }
    
    func setCurrentCurrency(currentCode: String) {
    
        UserDefaults.standard.set(currentCode, forKey: "CurrentCurrency")
        UserDefaults.standard.synchronize()
        
        CurrentCurrency.shared.currentCurrency = currentCode
        
    }
    
    func getCurrentCurrency() {
        
        if let currencyString = UserDefaults.standard.string(forKey: "CurrentCurrency") {
            CurrentCurrency.shared.currentCurrency = currencyString
        } else {
            CurrentCurrency.shared.currentCurrency = getDefaultCurrencyByLocale()
        }
        
    }
    
}
