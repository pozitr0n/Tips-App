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
    
    func convertAmountToAnotherCurrency(_ sumByString: String) -> String {
        
        var finalResult: String = ""
        
        guard let sumByDouble = Double(sumByString) else {
            return finalResult
        }
        
        let converted = getConvertedAmount(sumByDouble)

        finalResult = String(format: "%.2f", sumByDouble)

        return finalResult
        
    }
    
    func getConvertedAmount(_ sumByDouble: Double) -> Double {
        
        let currentCodeOfCurrency = CurrentCurrency.shared.currentCurrency
        
        return 0.0
        
    }
    
}

class CurrentPercentage {
    
    static let shared = CurrentPercentage()
    
    // Saving/getting using User Defaults
    var currentPercentage: Int = 0
    
    private init () {}
    
}

final class Percentage {
    
    func setCurrentPercentage(currentPercentage: Int) {
    
        UserDefaults.standard.set(currentPercentage, forKey: "CurrentPercentage")
        UserDefaults.standard.synchronize()
        
        CurrentPercentage.shared.currentPercentage = currentPercentage
        
    }
    
    func getCurrentPercentage() {
        CurrentPercentage.shared.currentPercentage = UserDefaults.standard.integer(forKey: "CurrentPercentage")
    }
    
}
