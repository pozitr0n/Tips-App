//
//  AppDelegate.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 11/03/2024.
//

import UIKit
import WatchConnectivity

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWatchConnectivity()
        return true
        
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    func setupWatchConnectivity() {
        
        if WCSession.isSupported() {
            
            let session = WCSession.default
            
            session.delegate = self
            session.activate()
            
        }
        
    }
    
}

var thisIsEnvironment: API_Keyable {
    
    #if DEBUG
        return DebugEnvironment()
    #else
        return ProdEnvironment()
    #endif
    
}

extension AppDelegate: WCSessionDelegate {
   
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
        if let error = error {
            fatalError("Can't activate session with error: \(error.localizedDescription)")
        }
        
        print("WC Session activated with state: \(activationState.rawValue)")
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
        print(#function)
        WCSession.default.activate()
        
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        
        if let bill = userInfo["bill"] as? Double, 
            let amountOfPeople = userInfo["amountOfPeople"] as? Double,
            let tipsPercent = userInfo["tipsPercent"] as? Double,
            let tip = userInfo["tip"] as? Double,
            let eachTip = userInfo["eachTip"] as? Double,
            let total = userInfo["total"] as? Double,
            let selectedCurrency = userInfo["selectedCurrency"] as? String {
            
            // save from Apple Watch to Realm database to the main device
            
            let currentDateTime = Date()

            let formatterShort = DateFormatter()
            formatterShort.timeStyle = .none
            formatterShort.dateStyle = .medium
            
            let formatterLong = DateFormatter()
            formatterLong.timeStyle = .medium
            formatterLong.dateStyle = .medium

            let currentShortDateTimeString = formatterShort.string(from: currentDateTime)
            let currentLongDateTimeString  = formatterLong.string(from: currentDateTime)
            
            print(TransferData().addTransferingDataToRealm(idDate: currentLongDateTimeString,
                                                     tipDate: currentShortDateTimeString,
                                                     tipCurrency: selectedCurrency,
                                                     tipBill: SmartTipsProWatchModelCalculations().getNSDecimalNumber(value: bill, maximumFractionDigits: 2),
                                                     tipPercent: SmartTipsProWatchModelCalculations().getNSDecimalNumber(value: tipsPercent, maximumFractionDigits: 2),
                                                     tipTips: SmartTipsProWatchModelCalculations().getNSDecimalNumber(value: tip, maximumFractionDigits: 2),
                                                     tipTotal: SmartTipsProWatchModelCalculations().getNSDecimalNumber(value: total, maximumFractionDigits: 2),
                                                     tipPeople: Int(SmartTipsProWatchModelCalculations().getNSDecimalNumber(value: amountOfPeople, maximumFractionDigits: 2)),
                                                     tipEachPay: SmartTipsProWatchModelCalculations().getNSDecimalNumber(value: eachTip, maximumFractionDigits: 2)))
                                                     
        }
        
    }
    
}
