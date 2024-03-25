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
