//
//  TipsModel.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 11/07/2024.
//

import Foundation
import RealmSwift

final class TipsModel {
    
    // Realm object
    let realm = try? Realm()
    
    func addTipsInfoToFavourite(_ idDate: String,
                                _ tipDate: String,
                                _ tipCurrency: String,
                                _ tipBill: Double,
                                _ tipPercent: Double,
                                _ tipTips: Double,
                                _ tipTotal: Double,
                                _ tipPeople: Int,
                                _ tipEachPay: Double) -> Bool {
        
        var result = false
    
        do {
            
            try realm?.write ({
                
                let object          = TipsModelObject()
                
                object.idDateString = idDate
                object.tipDate      = tipDate
                object.tipCurrency  = tipCurrency
                object.tipBill      = tipBill
                object.tipPercent   = tipPercent
                object.tipTips      = tipTips
                object.tipTotal     = tipTotal
                object.tipPeople    = tipPeople
                object.tipEachPay   = tipEachPay
                
                realm?.add(object, update: .all)
                
                result = true
                
            })
            
        } catch {
            print("Error saving done status, \(error)")
        }
        
        return result
        
    }
    
    func deleteTipsInfoFromFavourite(_ offsets: IndexSet, _ myFavouriteTips: Results<TipsModelObject>) {
    
        do {
            
            try realm?.write ({
                
                for index in offsets {
                    
                    // Checking the presence of an object in the array and its belonging to Realm
                    let itemToDelete = myFavouriteTips[index]
                    if let realmObject = realm?.object(ofType: TipsModelObject.self, forPrimaryKey: itemToDelete.id) {
                        realm?.delete(realmObject)
                    }
                    
                }
                
            })
            
        } catch {
            print("Error deleting done status, \(error)")
        }
        
    }
    
}
