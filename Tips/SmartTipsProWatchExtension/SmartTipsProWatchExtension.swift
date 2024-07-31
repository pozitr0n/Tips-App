//
//  SmartTipsProWatchExtension.swift
//  SmartTipsProWatchExtension
//
//  Created by Raman Kozar on 31/07/2024.
//

import AppIntents

struct SmartTipsProWatchExtension: AppIntent {
    static var title: LocalizedStringResource = "SmartTipsProWatchExtension"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
