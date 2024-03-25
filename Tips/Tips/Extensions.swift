//
//  Extensions.swift
//  Tips
//
//  Created by Raman Kozar on 25/03/2024.
//

import Foundation

extension Array where Element: Hashable {
    
    func uniqued() -> Array {
        
        var buffer = Array()
        var added = Set<Element>()
        
        for elem in self {
            
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
            
        }
        
        return buffer
        
    }
    
}

extension String {
    
    // * 1 *
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    // * 1 *
    
    // * 2 *
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
    // * 2 *
    
}
