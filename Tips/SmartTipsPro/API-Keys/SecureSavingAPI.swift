//
//  SecureSavingAPI.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 14/04/2024.
//

import Foundation

protocol API_Keyable {
    var EXCHANGE_RATES_API_KEY: String { get }
}

class BaseEnvironment {
    
    let dict: NSDictionary
    
    enum Key: String {
        case EXCHANGE_RATES_API_KEY
    }
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"), 
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find .plist file")
        }
        self.dict = plist
    }
    
}

class DebugEnvironment: BaseEnvironment, API_Keyable {
    
    init() {
        super.init(resourceName: "Debug-Keys")
    }
    
    var EXCHANGE_RATES_API_KEY: String {
        dict.object(forKey: Key.EXCHANGE_RATES_API_KEY.rawValue) as? String ?? ""
    }
    
}

class ProdEnvironment: BaseEnvironment, API_Keyable {
    
    init() {
        super.init(resourceName: "Prod-Keys")
    }
    
    var EXCHANGE_RATES_API_KEY: String {
        dict.object(forKey: Key.EXCHANGE_RATES_API_KEY.rawValue) as? String ?? ""
    }
    
}
