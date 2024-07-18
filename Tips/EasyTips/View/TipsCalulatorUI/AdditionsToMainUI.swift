//
//  AdditionsToMainUI.swift
//  EasyTips
//
//  Created by Raman Kozar on 04/06/2024.
//

// All the devices comparing to iOS 17.0
//
// iPhone SE (2. gen.) - screen4_7Inch
// iPhone SE (3. gen.) - screen4_7Inch


// iPhone 12 mini - screen5_4Inch
// iPhone 13 mini - screen5_4Inch


// iPhone 11 Pro - screen5_8Inch
// iPhone XS - screen5_8Inch


// iPhone XR - screen6_1Inch
// iPhone 11 - screen6_1Inch
// iPhone 12 - screen6_1Inch
// iPhone 12 Pro - screen6_1Inch
// iPhone 14 - screen6_1Inch
// iPhone 13 - screen6_1Inch
// iPhone 13 Pro - screen6_1Inch
// iPhone 14 Pro - screen6_1Inch_2
// iPhone 15 - screen6_1Inch_2
// iPhone 15 Pro - screen6_1Inch_2


// iPhone XS Max - screen6_5Inch
// iPhone 11 Pro Max - screen6_5Inch


// iPhone 12 Pro Max - screen6_7Inch
// iPhone 13 Pro Max - screen6_7Inch
// iPhone 14 Plus - screen6_7Inch
// iPhone 14 Pro Max - screen6_7Inch_2
// iPhone 15 Plus - screen6_7Inch
// iPhone 15 Pro Max - screen6_7Inch_2


//

import Device
import SwiftUI

final class ValuesForCalculations {
    
    func getDoubleCount(value: Int, maximumFractionDigits: Int) -> Double {
        
        let currentValue = Double(value)
        let currentDecimalValue = Decimal(currentValue / 100.0)
        
        return NSDecimalNumber(decimal: currentDecimalValue / pow(10, maximumFractionDigits) * 100).doubleValue
        
    }
    
}

final class ConstantsFactorValuesForMainUI {
    
    static let shared = ConstantsFactorValuesForMainUI()
    
    let scrollViewButtonWidth: CGFloat = 70
    let scrollViewButtonHeight: CGFloat = 8
    let scrollViewHeight: CGFloat = 60
    let paddingAddingCGFloat: CGFloat = 5
    
    private init () {}
    
}

final class FactorValuesForMainUI {
    
    func getVStackSpacing(currentInch: Size) -> CGFloat {
    
        var _VStackSpacing: CGFloat = 0
        
        if currentInch == .screen4_7Inch {
            _VStackSpacing = 10
        }
        else if currentInch == .screen5_4Inch || currentInch == .screen5_8Inch {
            _VStackSpacing = 15
        }
        else if currentInch == .screen6_1Inch || currentInch == .screen6_1Inch_2 || currentInch == .screen6_5Inch {
            _VStackSpacing = 20
        }
        else if currentInch == .screen6_7Inch || currentInch == .screen6_7Inch_2 {
            _VStackSpacing = 25
        } else {
            _VStackSpacing = 10
        }
        
        return _VStackSpacing
                
    }
    
    func getHStackSpacing(currentInch: Size) -> CGFloat {
    
        var _HStackSpacing: CGFloat = 0
        
        if currentInch == .screen4_7Inch {
            _HStackSpacing = 20
        }
        else if currentInch == .screen5_4Inch || currentInch == .screen5_8Inch {
            _HStackSpacing = 25
        }
        else if currentInch == .screen6_1Inch || currentInch == .screen6_1Inch_2 || currentInch == .screen6_5Inch {
            _HStackSpacing = 30
        }
        else if currentInch == .screen6_7Inch || currentInch == .screen6_7Inch_2 {
            _HStackSpacing = 35
        } else {
            _HStackSpacing = 20
        }
        
        return _HStackSpacing
                
    }
    
    func getCurrentPadding(currentInch: Size) -> CGFloat {
    
        var currentPadding: CGFloat = 0
        
        if currentInch == .screen4_7Inch {
            currentPadding = 20
        }
        else if currentInch == .screen5_4Inch || currentInch == .screen5_8Inch {
            currentPadding = 25
        }
        else if currentInch == .screen6_1Inch || currentInch == .screen6_1Inch_2 || currentInch == .screen6_5Inch {
            currentPadding = 30
        }
        else if currentInch == .screen6_7Inch || currentInch == .screen6_7Inch_2 {
            currentPadding = 35
        } else {
            currentPadding = 20
        }
        
        return currentPadding
        
    }
    
    func getCurrencyTipsTextFieldHeight(currentInch: Size) -> CGFloat {
        
        var currentCurrencyTipsTextFieldHeight: CGFloat = 0
        
        if currentInch == .screen4_7Inch {
            currentCurrencyTipsTextFieldHeight = 60
        }
        else if currentInch == .screen5_4Inch || currentInch == .screen5_8Inch {
            currentCurrencyTipsTextFieldHeight = 65
        }
        else if currentInch == .screen6_1Inch || currentInch == .screen6_1Inch_2 || currentInch == .screen6_5Inch {
            currentCurrencyTipsTextFieldHeight = 70
        }
        else if currentInch == .screen6_7Inch || currentInch == .screen6_7Inch_2 {
            currentCurrencyTipsTextFieldHeight = 75
        } else {
            currentCurrencyTipsTextFieldHeight = 60
        }
        
        return currentCurrencyTipsTextFieldHeight
        
    }
    
    func getCurrencyTipsMainFont(currentInch: Size) -> CGFloat {
        
        var currentTipsMainFont: CGFloat = 16
        
        if currentInch == .screen4_7Inch || currentInch == .screen5_4Inch || currentInch == .screen5_8Inch {
            currentTipsMainFont = 16
        }
        else if currentInch == .screen6_1Inch || currentInch == .screen6_1Inch_2 || currentInch == .screen6_5Inch || currentInch == .screen6_7Inch || currentInch == .screen6_7Inch_2 {
            currentTipsMainFont = 18
        } else {
            currentTipsMainFont = 16
        }
        
        return currentTipsMainFont
        
    }
    
}
