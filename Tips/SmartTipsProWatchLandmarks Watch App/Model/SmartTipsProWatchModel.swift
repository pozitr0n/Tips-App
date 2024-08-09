//
//  SmartTipsProWatchModel.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 31/07/2024.
//

import Foundation

final class SmartTipsProWatchModel: ObservableObject {
    
    // Calculated yet
    var amountOfTips: Double
    var amountPerPerson: Double
    var totalBill: Double
    
    // Initialization
    //
    init() {
    
        amountOfTips = 0.00
        amountPerPerson = 0.00
        totalBill = 0.00
        
    }
    
    // Billing Tips
    @Published var billTips = "" {
        didSet {
            updateTipsInfo()
        }
    }
    
    // Tips Percentage
    @Published var percentOfTips = UI_Constants.shared.tipsPercentage {
        didSet {
            updateTipsInfo()
        }
    }
    
    // Tips Percentage (string, for entering the value)
    @Published var tipPercentString = "" {
        
        didSet {
            if let percentOfTipsValue = Double(tipPercentString) { percentOfTips = percentOfTipsValue }
            else if tipPercentString == "" { percentOfTips = UI_Constants.shared.tipsPercentage }
        }
        
    }
    
    // Amount Of People
    @Published var amountOfPeople = "" {
        didSet {
            updateTipsInfo()
        }
    }
    
    func updateTipsInfo() {
        
        if let billTipsValue = Double(billTips) {
            
            let amountOfPeopleValue = Double(amountOfPeople) ?? 1.0
            
            if billTipsValue >= 0 && amountOfPeopleValue > 0  {
                
                amountOfTips    = billTipsValue * percentOfTips / 100
                totalBill       = billTipsValue + amountOfTips
                amountPerPerson = totalBill / amountOfPeopleValue

            } else {
                
                amountOfTips    = 0.00
                amountPerPerson = 0.00
                totalBill       = 0.00
                
            }
            
        }
        
    }
    
    func incrementingAmountOfPeople() {
        
        if var amountOfPeopleValue = Int(amountOfPeople) {
            
            amountOfPeopleValue += 1
            amountOfPeople      = String(amountOfPeopleValue)
            
        } else if amountOfPeople == "" {
            amountOfPeople      = "2"
        }
        
    }
    
    func decrementingAmountOfPeople() {
        
        if var amountOfPeopleValue = Int(amountOfPeople) {
            
            if amountOfPeopleValue > 1 {
                
                amountOfPeopleValue -= 1
                amountOfPeople      = String(amountOfPeopleValue)
                
            }
            
        }
        
    }
    
    func incrementingAmountOfPeopleEnabled() -> Bool {
        
        if let amountOfPeopleValue = Int(amountOfPeople) {
            return amountOfPeopleValue <= 50 ? true : false
        }
        
        return true
        
    }
    
    func decrementingAmountOfPeopleEnabled() -> Bool {
        return amountOfPeople == "" || amountOfPeople == "1" ? false : true
    }
    
}
