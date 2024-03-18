//
//  Localizations.swift
//  Tips
//
//  Created by Raman Kozar on 18/03/2024.
//

import Foundation

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

// LocalizedString to get string in selected language
//
func Localize(key: Any, comment: Any) -> String {
    return AppLocalization.sharedInstance.localizedString(forKey: (key as! String), value: (comment as! String))
}
