//
//  AppDelegate.swift
//  EasyTips
//
//  Created by Raman Kozar on 11/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
}

var thisIsEnvironment: API_Keyable {
    
    #if DEBUG
        return DebugEnvironment()
    #else
        return ProdEnvironment()
    #endif
    
}
