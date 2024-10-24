//
//  SmartTipsProWatchModel.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 31/07/2024.
//

import Foundation
import WatchConnectivity

protocol CalculationsWatchOS {
    
    func updateTipsInfo()
    func incrementingAmountOfPeople()
    func incrementingAmountOfPeopleEnabled() -> Bool
    func decrementingAmountOfPeople()
    func decrementingAmountOfPeopleEnabled() -> Bool
    func transferDataTo_iPhone() -> Bool
    
}

class SmartTipsProWatchModel: ObservableObject, CalculationsWatchOS {
    
    // Calculated yet
    var amountOfTips: Double
    var amountPerPerson: Double
    var totalBill: Double
    var billTipsValue: Double
    var amountOfPeopleValue: Double
    var selectedCurrencyValue: String
    
    // Initialization
    //
    init() {
    
        amountOfTips = 0.00
        amountPerPerson = 0.00
        totalBill = 0.00
        billTipsValue = 0.00
        amountOfPeopleValue = 0.00
        selectedCurrencyValue = ""

    }

    // Billing Tips
    @Published var billTips = "" {
        didSet {
            updateTipsInfo()
        }
    }
    
    // Currency
    @Published var selectedCurrency = UI_Constants.shared.selectedCurrency {
        didSet {
            updateTipsInfo()
        }
    }
    
    // Tips Percentage
    @Published var percentOfTips = 0.0 {
        didSet {
            updateTipsInfo()
        }
    }
    
    // Tips Percentage (string, for entering the value)
    @Published var tipPercentString = "" {
        
        didSet {
            if let percentOfTipsValue = Double(tipPercentString) { percentOfTips = percentOfTipsValue }
            else if tipPercentString == "" { percentOfTips = 0.0 }
        }
        
    }
    
    // Amount Of People
    @Published var amountOfPeople = "" {
        didSet {
            updateTipsInfo()
        }
    }
    
    func updateTipsInfo() {
        
        if let currBillTipsValue = Double(billTips) {
            
            selectedCurrencyValue = selectedCurrency
            AppleWatchCurrencies().setCurrentCurrency(currentCode: selectedCurrencyValue)
            
            billTipsValue = currBillTipsValue
            
            let curr_amountOfPeopleValue = Double(amountOfPeople) ?? 1.0
            amountOfPeopleValue = curr_amountOfPeopleValue
            
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
    
    func transferDataTo_iPhone() -> Bool {
    
        if amountOfTips == 0.00 && amountPerPerson == 0.00 && totalBill == 0.00 && billTipsValue == 0.00 && amountOfPeopleValue == 0.00 {
            return true
        }
        
        if WCSession.isSupported() {
        
            let session = WCSession.default
            
            let dictionaryToTransfer: [String : Any] = ["bill" : billTipsValue,
                                                        "amountOfPeople" : amountOfPeopleValue,
                                                        "tipsPercent" : percentOfTips,
                                                        "tip" : amountOfTips,
                                                        "eachTip" : amountPerPerson,
                                                        "total" : totalBill,
                                                        "selectedCurrency" : selectedCurrency]
            
            session.transferUserInfo(dictionaryToTransfer)
            
            // add clearing to all the parameters
            percentOfTips = 0.00
            
            billTips = ""
            billTipsValue = 0.00
            
            amountOfPeople = ""
            amountOfPeopleValue = 0.00
            
            amountPerPerson = 0.00
            totalBill = 0.00
            
            return false
            
        }
        
        return true
        
    }
    
}


