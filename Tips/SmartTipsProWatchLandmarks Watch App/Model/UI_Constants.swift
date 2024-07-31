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
    
    // Change to Percentage().getCurrentPercentage()
    let tipsPercentage = 20.0
    
    let imageSpacerWidth: CGFloat = 8.0
    
    private init () {}
    
}
