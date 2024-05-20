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
        
    func getCurrentAPI_Key() {
        CurrentExchangeRatesDataAPI_Key.shared.currentAPI_Key = thisIsEnvironment.EXCHANGE_RATES_API_KEY
    }
    
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

final class MappingCurrencyToRegion {

    static let locales = Locale.availableIdentifiers.map(Locale.init)

    static func locales(currencyCode: String) -> Set<Locale> {
        
        let localesWithCode = self.locales.filter { locale in
            locale.currency?.identifier == currencyCode
        }
                
        return Set(localesWithCode)
        
    }

    static func locales(currencySymbol: String) -> Set<Locale> {
        
        let localesWithSymbol = self.locales.filter { locale in
            locale.currencySymbol == currencySymbol
        }
        
        return Set(localesWithSymbol)
        
    }

    static func regionNames(currencyCode: String, forLocale locale: Locale = Locale.autoupdatingCurrent) -> Set<String> {
        
        let locale = Locale(identifier: locale.identifier) // .current and .autoupdatingCurrent doesn't work without this hack for some reason
        let localesForCode = self.locales(currencyCode: currencyCode)
        let names: [String] = localesForCode.compactMap { loc in
            
            if let regionCode = loc.region?.identifier {
                return locale.localizedString(forRegionCode: regionCode)
            } else {
                return locale.localizedString(forIdentifier: loc.identifier)
            }
            
        }
        
        return Set(names)
        
    }

    static func regionNames(currencySymbol: String, forLocale locale: Locale = Locale.autoupdatingCurrent) -> Set<String> {
        
        let locale = Locale(identifier: locale.identifier) // .current and .autoupdatingCurrent doesn't work without this hack for some reason
        let localesForSymbol = self.locales(currencySymbol: currencySymbol)
        let names: [String] = localesForSymbol.compactMap { loc in
        
            if let regionCode = loc.region?.identifier {
                return locale.localizedString(forRegionCode: regionCode)
            } else {
                return locale.localizedString(forIdentifier: loc.identifier)
            }
            
        }
        
        return Set(names)
        
    }

}

class CurrentExchangeRatesDataAPI_Key {
    
    static let shared = CurrentExchangeRatesDataAPI_Key()
    
    // Saving/getting using Keychain
    var currentAPI_Key = ""
    
    private init () {}
    
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

class MaximumBillTotalLength {
    
    static let shared = MaximumBillTotalLength()
    let maxBillLength: Decimal = 100000000
    private init () {}
    
}
