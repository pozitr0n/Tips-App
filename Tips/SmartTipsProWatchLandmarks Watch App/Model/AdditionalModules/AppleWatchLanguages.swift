//
//  AppleWatchLanguages.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 28/08/2024.
//

import Foundation

enum AppleWatchModelLanguagesOptions: String, CaseIterable, Codable {
    
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

class AppleWatchCurrentLanguage {
    
    static let shared = AppleWatchCurrentLanguage()
    
    // Saving/getting using User Defaults
    var currentLanguage = AppleWatchModelLanguagesOptions.en
    
    private init () {}
    
}

final class AppleWatchModelLanguages {

    var languagesCodesWithValues: [String: String] = ["en": "English", "pl": "Polska", "ru": "Русский"]
    var languagesValuesWithCodes: [String: String] = ["English": "en", "Polska": "pl", "Русский": "ru"]
        
    func setCurrentLanguage(lang: AppleWatchModelLanguagesOptions) {
    
        if let encoded = try? JSONEncoder().encode(lang) {
            
            UserDefaults.standard.set(encoded, forKey: "AppleWatchCurrentLanguage")
            UserDefaults.standard.synchronize()
        }
        
        let langCode = languagesValuesWithCodes[lang.rawValue]!
        let path: String? = Bundle.main.path(forResource: langCode, ofType: "lproj")
        
        AppleWatchAppLocalization.sharedInstance.workWithLocalization(currPath: path)
        AppleWatchCurrentLanguage.shared.currentLanguage = lang
        
    }
    
    func getCurrentLanguage() {
        
        if let languageData = UserDefaults.standard.object(forKey: "AppleWatchCurrentLanguage") as? Data,
           let currentLanguage = try? JSONDecoder().decode(AppleWatchModelLanguagesOptions.self, from: languageData) {
            
            let langCode = languagesValuesWithCodes[currentLanguage.rawValue]!
            let path: String? = Bundle.main.path(forResource: langCode, ofType: "lproj")
            
            AppleWatchAppLocalization.sharedInstance.workWithLocalization(currPath: path)
            AppleWatchCurrentLanguage.shared.currentLanguage = currentLanguage
            
        } else {
            AppleWatchCurrentLanguage.shared.currentLanguage = getDefaultLanguage()
        }
        
    }
    
    func getDefaultLanguage() -> AppleWatchModelLanguagesOptions {
    
        // Initialization
        var currentLanguageEnum: AppleWatchModelLanguagesOptions = AppleWatchModelLanguagesOptions.en
        
        // Locale.current.languageCode does not compile regularly, because I haven't implemented localization into my project
        // Returns phone language properly
        let currentLanguage = String(Locale.preferredLanguages[0].prefix(2))
        
        let languageNames: [String] = AppleWatchModelLanguages().getArrayOfLocalizationCodes()
        
        if languageNames.contains(where: {$0 == currentLanguage}) {
            currentLanguageEnum = AppleWatchModelLanguagesOptions(rawValue: languagesCodesWithValues[currentLanguage]!)!
        }
        
        let langCode = languagesValuesWithCodes[currentLanguageEnum.rawValue]!
        let path: String? = Bundle.main.path(forResource: langCode, ofType: "lproj")
        
        AppleWatchAppLocalization.sharedInstance.workWithLocalization(currPath: path)
        
        return currentLanguageEnum
        
    }
    
    func getArrayOfLocalizationCodes() -> [String] {
     
        var languageNames: [String] = []
        
        for curr in languagesCodesWithValues {
            languageNames.append(curr.key)
        }
        
        return languageNames
        
    }
    
    func getLanguageByName(_ languageName: String) -> AppleWatchModelLanguagesOptions {
        
        guard let lang = AppleWatchModelLanguagesOptions(rawValue: languageName) else {
            return AppleWatchCurrentLanguage.shared.currentLanguage
        }
        
        return lang
        
    }
    
}

class AppleWatchAppLocalization: NSObject {
    
    static let sharedInstance = AppleWatchAppLocalization()
    var bundle: Bundle = Bundle.main
    
    // get localizedString from bundle of selected language
    //
    func localizedString(forKey key: String, value comment: String) -> String {
    
        let localized = bundle.localizedString(forKey: key, value: comment, table: nil)
        return localized
        
    }
    
    // Working with localization
    //
    func workWithLocalization(currPath: String?) {
        
        if let currPath,
            let bundle = Bundle(path: currPath) {
            self.bundle = bundle
        } else {
            // in case the language does not exists
            resetLocalization()
        }
        
    }
    
    // reset bundle
    //
    func resetLocalization() {
        bundle = Bundle.main
    }
  
}
