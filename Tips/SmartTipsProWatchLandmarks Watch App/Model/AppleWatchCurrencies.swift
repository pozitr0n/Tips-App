//
//  AppleWatchCurrencies.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 27/08/2024.
//

import Foundation

final class AppleWatchCurrencies {
        
    func getDefaultCurrencyByLocale() -> String {
        
        let locale = Locale.current
        
        guard let currency = locale.currency else {
            return "PLN"
        }
        
        return currency.identifier
        
    }
    
    func setCurrentCurrency(currentCode: String) {
    
        UserDefaults.standard.set(currentCode, forKey: "AppleWatchCurrentCurrency")
        UserDefaults.standard.synchronize()
        
        UI_Constants.shared.selectedCurrency = currentCode
        
    }
    
    func getCurrentCurrency() {
        
        if let currencyString = UserDefaults.standard.string(forKey: "AppleWatchCurrentCurrency") {
            UI_Constants.shared.selectedCurrency = currencyString
        } else {
            UI_Constants.shared.selectedCurrency = getDefaultCurrencyByLocale()
        }
        
    }
    
}

