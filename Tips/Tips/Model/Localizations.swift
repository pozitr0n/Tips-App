//
//  Localizations.swift
//  Tips
//
//  Created by Raman Kozar on 18/03/2024.
//

import Foundation

// LocalizedString to get string in selected language
//
func Localize(key: Any, comment: Any) -> String {
    return AppLocalization.sharedInstance.localizedString(forKey: (key as! String), value: (comment as! String))
}

class AppLocalization: NSObject {
    
    static let sharedInstance = AppLocalization()
    var bundle: Bundle? = nil
    
    // get localizedString from bundle of selected language
    //
    func localizedString(forKey key: String, value comment: String) -> String {
    
        let localized = bundle!.localizedString(forKey: key, value: comment, table: nil)
        return localized
        
    }
    
    // Working with localization
    //
    func workWithLocalization(currPath: String?) {
        
        if currPath == nil {
            // in case the language does not exists
            resetLocalization()
        }
        else {
            bundle = Bundle(path: currPath!)
        }
        
    }
    
    // reset bundle
    //
    func resetLocalization() {
        bundle = Bundle.main
    }
  
}

extension String {

    func localizedSwiftUI(_ language: LanguageOptions) -> String {
        
        let langCode = Languages().languagesValuesWithCodes[language.rawValue]!
        let path: String? = Bundle.main.path(forResource: langCode, ofType: "lproj")
        
        let bundle: Bundle
        
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        
        return localizedSwiftUIPrivate(bundle: bundle)
        
    }

    private func localizedSwiftUIPrivate(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
}
