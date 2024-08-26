//
//  TransferData.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 26/08/2024.
//

import Foundation

final class TransferData {
    
    func addTransferingDataToRealm(idDate: String, tipDate: String, tipCurrency: String, tipBill: Double, tipPercent: Double, tipTips: Double, tipTotal: Double, tipPeople: Int, tipEachPay: Double) -> Bool {
        
        return TipsModel().addTipsInfoToFavourite(idDate, tipDate, tipCurrency, tipBill, tipPercent, tipTips, tipTotal, tipPeople, tipEachPay)
        
    }
    
}
