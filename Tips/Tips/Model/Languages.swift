//
//  Languages.swift
//  Tips
//
//  Created by Raman Kozar on 15/03/2024.
//

import Foundation

enum LanguageOptions: String, CaseIterable, Codable {
    
    case en = "English"
    case pl = "Polska"
    case ru = "Русский"
    
    init?(id : Int) {
        switch id {
        case 1: self = .en
        case 2: self = .pl
        case 3: self = .ru
        default: return nil
        }
    }
    
}

var languagesCodesWithValues: [String: String] = ["en": "English", "pl": "Polska", "ru": "Русский"]

class CurrentLanguage {
    
    static let shared = CurrentLanguage()
    
    // Saving/getting using User Defaults
    var currentLanguage = LanguageOptions.en
    
    private init () {}
    
}

final class Languages {

    func getArrayOfLocalizationCodes() -> [String] {
     
        var languageNames: [String] = []
        
        for curr in languagesCodesWithValues {
            languageNames.append(curr.key)
        }
        
        return languageNames
        
    }
    
    func getArrayOfLanguages() -> [LanguageOptions] {
        return LanguageOptions.allCases
    }
    
    func setCurrentLanguage(lang: LanguageOptions) {
    
        if let encoded = try? JSONEncoder().encode(lang) {
            UserDefaults.standard.set(encoded, forKey: "CurrentLanguage")
        }
        
        CurrentLanguage.shared.currentLanguage = lang
        
    }
    
    func getCurrentLanguage() {
        
        if let languageData = UserDefaults.standard.object(forKey: "CurrentLanguage") as? Data,
           let currentLanguage = try? JSONDecoder().decode(LanguageOptions.self, from: languageData) {
            CurrentLanguage.shared.currentLanguage = currentLanguage
        } else {
            CurrentLanguage.shared.currentLanguage = getDefaultLanguage()
        }
        
    }
    
    func getDefaultLanguage() -> LanguageOptions {
    
        // Initialization
        var currentLanguageEnum: LanguageOptions = LanguageOptions.en
        
        // Locale.current.languageCode does not compile regularly, because I haven't implemented localization into my project
        // Returns phone language properly
        let currentLanguage = String(Locale.preferredLanguages[0].prefix(2))
        
        let languageNames: [String] = Languages().getArrayOfLocalizationCodes()
        
        if languageNames.contains(where: {$0 == currentLanguage}) {
            currentLanguageEnum = LanguageOptions(rawValue: languagesCodesWithValues[currentLanguage]!)!
        }
        
        return currentLanguageEnum
        
    }
    
}

