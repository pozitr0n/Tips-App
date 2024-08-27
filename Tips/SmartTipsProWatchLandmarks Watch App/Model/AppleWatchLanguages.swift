//
//  AppleWatchLanguages.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 27/08/2024.
//

import Foundation

enum AppleWatchLanguageOptions: String, CaseIterable, Codable {
    
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
