//
//  OutputView.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 31/07/2024.
//

import SwiftUI

struct OutputView: View {
    
    var label: String
    var value: Double
    var format: String
    
    var body: some View {
        Button(action: {}) {
            HStack(alignment: .center) {
                Text(label)
                    .font(.title3)
                Spacer()
                Text(String(format: format, value))
                    .font(.title2)
                    .bold()
            }
        }
        .disabled(true)
    }
    
}
