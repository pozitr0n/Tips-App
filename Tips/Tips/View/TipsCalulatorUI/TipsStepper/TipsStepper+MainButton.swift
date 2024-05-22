//
//  TipsStepper+MainButton.swift
//  Tips
//
//  Created by Raman Kozar on 22/05/2024.
//

import SwiftUI

struct MainButton: View {
    
    var imageSystemName: String
    var imageSize: CGFloat
    var propertyIsActive: Bool
    var propertyOpacity: Double
    var buttonAction: () -> Void = {}
    
    var body: some View {
        
        Button(action: buttonAction) {
            Image(systemName: imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(imageSize / 3.5)
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(Color.textButtonColorBackground.opacity(propertyOpacity))
                .background(Color.textButtonColorBackground.opacity(0.0000001))
                .clipShape(Circle())
        }
        .buttonStyle(MainButtonStyle(systemName: imageSystemName, size: imageSize))
        .contentShape(Circle())
        
    }
    
}

struct MainButtonStyle: ButtonStyle {
    
    var systemName: String
    var size: CGFloat
    var padding: CGFloat
    
    init(systemName: String, size: CGFloat) {
        
        self.systemName = systemName
        self.size = size
        self.padding = size / 3.5
        
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .overlay(
                ZStack {
                    
                    Image(systemName: systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(padding)
                        .foregroundColor(.controlBackground)
                    
                }
                    .frame(width: size, height: size)
                    .opacity(configuration.isPressed ? 1 : 0)
                    .animation(.linear(duration: 0.1), value: configuration.isPressed)
            )
            .font(.system(size: 60, weight: .thin, design: .rounded))
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
        
    }
    
}
