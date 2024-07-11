//
//  TipsModel.swift
//  Tips
//
//  Created by Raman Kozar on 11/07/2024.
//

import Foundation
import RealmSwift

final class TipsModel {
    
    // Realm object
    let realm = try? Realm()
    
    var allTheInfoTips: Results<TipsModelObject>? {
        return realm?.objects(TipsModelObject.self)
    }
    
    func addTipsInfoToFavourite(_ idDate: String,
                                _ tipDate: String,
                                _ tipCurrency: String,
                                _ tipBill: Double,
                                _ tipPercent: Double,
                                _ tipTips: Double,
                                _ tipTotal: Double,
                                _ tipPeople: Int,
                                _ tipEachPay: Double) {
    
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
                
            })
            
        } catch {
            print("Error saving done status, \(error)")
        }
        
    }
    
    func deleteTipsInfoFromFavourite() {
        
    }
    
    func searchInfoInFavourite() {
        
    }
    
    func getAllTheInfoTips() -> [FavouriteObject] {
        
        var favouriteArray: [FavouriteObject] = []
        
        guard let allTheInfoTips = allTheInfoTips else {
            return [FavouriteObject]()
        }
        
        for element in allTheInfoTips {
            
            let newElement = FavouriteObject(idDateString: element.idDateString, 
                                             tipDate: element.tipDate,
                                             tipCurrency: element.tipCurrency,
                                             tipBill: element.tipBill, 
                                             tipPercent: element.tipPercent,
                                             tipTips: element.tipTips,
                                             tipTotal: element.tipTotal,
                                             tipPeople: element.tipPeople,
                                             tipEachPay: element.tipEachPay)
            
            favouriteArray.append(newElement)
            
        }
        
        return favouriteArray
        
    }

}
