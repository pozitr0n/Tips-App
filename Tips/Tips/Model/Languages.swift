//
//  Languages.swift
//  Tips
//
//  Created by Raman Kozar on 15/03/2024.
//

import Foundation
import UIKit

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

class CurrentLanguage {
    
    static let shared = CurrentLanguage()
    
    // Saving/getting using User Defaults
    var currentLanguage = LanguageOptions.en
    
    private init () {}
    
}

final class Languages {

    var languagesCodesWithValues: [String: String] = ["en": "English", "pl": "Polska", "ru": "Русский"]
    var languagesValuesWithCodes: [String: String] = ["English": "en", "Polska": "pl", "Русский": "ru"]
    
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
            UserDefaults.standard.synchronize()
        }
        
        let langCode = languagesValuesWithCodes[lang.rawValue]!
        let path: String? = Bundle.main.path(forResource: langCode, ofType: "lproj")
        
        AppLocalization.sharedInstance.workWithLocalization(currPath: path)
        CurrentLanguage.shared.currentLanguage = lang
        
    }
    
    func getCurrentLanguage() {
        
        if let languageData = UserDefaults.standard.object(forKey: "CurrentLanguage") as? Data,
           let currentLanguage = try? JSONDecoder().decode(LanguageOptions.self, from: languageData) {
            
            let langCode = languagesValuesWithCodes[currentLanguage.rawValue]!
            let path: String? = Bundle.main.path(forResource: langCode, ofType: "lproj")
            
            AppLocalization.sharedInstance.workWithLocalization(currPath: path)
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
        
        let langCode = languagesValuesWithCodes[currentLanguageEnum.rawValue]!
        let path: String? = Bundle.main.path(forResource: langCode, ofType: "lproj")
        
        AppLocalization.sharedInstance.workWithLocalization(currPath: path)
        
        return currentLanguageEnum
        
    }
    
    // Animating of changing language
    //
    func animateChangingLanguage(window: UIWindow?, tabBarController: UITabBarController, animationOption: UIView.AnimationOptions) {
    
        guard let window = window else {
            return
        }
        
        var snapShot = UIView()
        
        if let realSnapShot = window.snapshotView(afterScreenUpdates: true) {
            snapShot = realSnapShot
        }
        
        tabBarController.view.addSubview(snapShot)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        if let styleTitle = UserDefaults.standard.string(forKey: "userTheme"),
           let style = Mode(rawValue: styleTitle)?.style {
            SceneDelegate().changeDarkLightMode(mode: style)
        }
        
        UIView.transition(
            with: window,
            duration: 1.0,
            options: animationOption,
            animations: {
                snapShot.transform = CGAffineTransform(translationX: 0, y: snapShot.frame.height)
            },
            completion: { status in
                snapShot.removeFromSuperview()
            }
        )
        
    }
    
    func getFlagByCountryCode(country: String) -> String {
        
        let base: UInt32 = 127397
        var s = ""
        
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        
        return String(s)
        
    }
    
}

class LanguagesUISettings: ObservableObject {
    
    func getLanguagesForDetailFormat() -> [LanguageObject] {
     
        var allLanguages: [LanguageObject] = []
        
        for lang in Languages().getArrayOfLanguages() {
        
            let newLanguage = LanguageObject(language: lang.rawValue,
                                             isOn: lang.rawValue == CurrentLanguage.shared.currentLanguage.rawValue)
            allLanguages.append(newLanguage)
            
        }
        
        return allLanguages
        
    }
    
    func getLanguageByName(_ languageName: String) -> LanguageOptions {
        
        guard let lang = LanguageOptions(rawValue: languageName) else {
            return CurrentLanguage.shared.currentLanguage
        }
        
        return lang
        
    }
        
}

