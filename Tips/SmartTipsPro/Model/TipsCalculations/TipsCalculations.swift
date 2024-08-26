//
//  TipsCalculations.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 08/06/2024.
//

import Foundation

class TipsCalculations {

    // Summary Part
    // ============
    
    // Calculating bill summary
    //
    func calculateBillSummary(startSum: Double) -> Double {
        return startSum == 0 ? 0.00 : startSum
    }
    
    // Calculating tip summary
    //
    func calculateTipSummary(startSum: Double, percent: Double) -> Double {
        
        var calcTipSummary: Double = 0.00
        
        if startSum == 0 || percent == 0 {
            calcTipSummary = 0.00
        } else {
            calcTipSummary = startSum * percent / 100
        }
        
        return calcTipSummary
        
    }
    
    // Calculating total summary
    //
    func calculateTotalSummary(startSum: Double, percent: Double) -> Double {
        
        var calcTotalSummary: Double = 0.00
        
        if startSum == 0 {
            calcTotalSummary = 0.00
        } else {
            
            if percent == 0 {
                calcTotalSummary = startSum
            } else {
                calcTotalSummary = startSum * (1 + percent / 100)
            }
            
        }
        
        return calcTotalSummary
        
    }
    
    // Per Person Part
    // ===============
    
    // Calculating bill per person
    //
    func calculateBillPerPerson(startSum: Double, numberOfPersons: Int) -> Double {
        return startSum == 0 ? 0.00 : startSum / Double(numberOfPersons)
    }
    
    // Calculating tip per person
    //
    func calculateTipPerPerson(startSum: Double, percent: Double, numberOfPersons: Int) -> Double {
        return startSum == 0 ? 0.00 : (startSum * (percent / 100)) / Double(numberOfPersons)
    }
    
    // Calculating total per person
    //
    func calculateTotalPerPerson(startSum: Double, percent: Double, numberOfPersons: Int) -> Double {
        startSum == 0 ? 0.00 : (startSum + (startSum * (percent / 100))) / Double(numberOfPersons)
    }
    
}

final class SmartTipsProWatchModelCalculations {
    
    func getNSDecimalNumber(value: Double, maximumFractionDigits: Int) -> Double {
        
        let decimalNumber = NSDecimalNumber(value: value)
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return Double(truncating: decimalNumber.rounding(accordingToBehavior: roundingBehavior))
        
    }
    
}
