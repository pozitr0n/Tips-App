//
//  SmartTipsProWatchLandmarksApp.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 29/07/2024.
//

import SwiftUI

@main
struct SmartTipsProWatchLandmarks_Watch_AppApp: App {
    
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
