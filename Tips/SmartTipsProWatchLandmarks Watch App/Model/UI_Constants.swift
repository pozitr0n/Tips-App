//
//  UI_Constants.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 31/07/2024.
//

import Foundation
import SwiftUI

class UI_Constants {
    
    static let shared = UI_Constants()
    
    // Default Decimal Pad button color
    let smartTipsProDecimalPadButtonColor = Color(red: 0.085, green: 0.085, blue: 0.085)
    
    let imageSpacerWidth: CGFloat = 8.0
    
    // Future settings for UserDefaults for Apple Watch
    // **
    var selectedCurrency: String = ""
    let currentLanguage = AppleWatchLanguageOptions.en
    // **
    
    private init () {}
    
}
