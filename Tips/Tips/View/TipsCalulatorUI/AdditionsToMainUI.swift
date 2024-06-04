//
//  AdditionsToMainUI.swift
//  Tips
//
//  Created by Raman Kozar on 04/06/2024.
//

// All the devices comparing to iOS 17.0
//
// iPhone SE (2. gen.) - screen4_7Inch
// iPhone SE (3. gen.) - screen4_7Inch
// iPhone XR - screen6_1Inch
// iPhone XS - screen5_8Inch
// iPhone XS Max - screen6_5Inch
// iPhone 11 - screen6_1Inch
// iPhone 11 Pro - screen5_8Inch
// iPhone 11 Pro Max - screen6_5Inch
// iPhone 12 mini - screen5_4Inch
// iPhone 12 - screen6_1Inch
// iPhone 12 Pro - screen6_1Inch
// iPhone 12 Pro Max - screen6_7Inch
// iPhone 13 mini - screen5_4Inch
// iPhone 13 - screen6_1Inch
// iPhone 13 Pro - screen6_1Inch
// iPhone 13 Pro Max - screen6_7Inch
// iPhone 14 - screen6_1Inch
// iPhone 14 Plus - screen6_7Inch
// iPhone 14 Pro - screen6_1Inch_2
// iPhone 14 Pro Max - screen6_7Inch_2
// iPhone 15 - screen6_1Inch_2
// iPhone 15 Plus - screen6_7Inch
// iPhone 15 Pro - screen6_1Inch_2
// iPhone 15 Pro Max - screen6_7Inch_2

import Device

enum ModelsWithChangeFactor: Double {
    
    case screen4_7Inch = 1.0
    case screen5_4Inch = 1.01
    case screen5_8Inch = 1.02
    case screen6_1Inch = 1.03
    case screen6_5Inch = 1.04
    case screen6_7Inch = 1.05
    
}
