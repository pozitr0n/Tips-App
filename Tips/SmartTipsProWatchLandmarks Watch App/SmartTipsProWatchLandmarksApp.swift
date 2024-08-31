//
//  SmartTipsProWatchLandmarksApp.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 29/07/2024.
//

import SwiftUI
import WatchConnectivity
import WatchKit

@main
struct SmartTipsProWatchLandmarks_Watch_AppApp: App {
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var extensionDelegate
    @StateObject private var model = SmartTipsProWatchModel()

    @SceneBuilder var body: some Scene {

        WindowGroup {
            NavigationView {
                SmartTipsProContentView()
                    .environmentObject(model)
            }
        }
        
    }
    
}

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
    
    override init() {
        
        super.init()
        
        setupWatchConnectivity()
        setupUserDefaultSettings()
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
        if let error = error {
            fatalError("Can't activate session with error: \(error.localizedDescription)")
        }
        
        print("WC Session activated with state: \(activationState.rawValue)")
        
    }
    
    func setupWatchConnectivity() {
        
        if WCSession.isSupported() {
            
            let session = WCSession.default
            
            session.delegate = self
            session.activate()
            
        }
        
    }
    
    // setup user defaults settings before start the app
    //
    func setupUserDefaultSettings() {
        AppleWatchCurrencies().getCurrentCurrency()
        AppleWatchModelLanguages().getCurrentLanguage()
    }
    
}
