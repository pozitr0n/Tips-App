//
//  Languages.swift
//  Tips
//
//  Created by Raman Kozar on 15/03/2024.
//

import Foundation

enum LanguageOptions: String, CaseIterable {
    
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
    var currentLanguage = LanguageOptions.en
    private init () {}
    
}

final class Languages {

    func getArrayOfLanguages() -> [LanguageOptions] {
        return LanguageOptions.allCases
    }
    
}

