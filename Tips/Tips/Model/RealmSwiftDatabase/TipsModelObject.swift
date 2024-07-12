//
//  TipsModelObject.swift
//  Tips
//
//  Created by Raman Kozar on 11/07/2024.
//

import Foundation
import RealmSwift

final class TipsModelObject: Object, Identifiable {
    
    @objc dynamic var id = UUID().uuidString
    
    @objc dynamic var idDateString: String = ""
    @objc dynamic var tipDate: String = ""
    @objc dynamic var tipCurrency: String = ""
    @objc dynamic var tipBill: Double = 0.0
    @objc dynamic var tipPercent: Double = 0.0
    @objc dynamic var tipTips: Double = 0.0
    @objc dynamic var tipTotal: Double = 0.0
    @objc dynamic var tipPeople: Int = 0
    @objc dynamic var tipEachPay: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
