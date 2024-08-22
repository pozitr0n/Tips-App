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
    
}
