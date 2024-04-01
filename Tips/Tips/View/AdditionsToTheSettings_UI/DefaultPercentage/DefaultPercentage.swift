//
//  DefaultPercentage.swift
//  Tips
//
//  Created by Raman Kozar on 01/04/2024.
//

import SwiftUI

struct DefaultPercentage: View {
    
    @State private var text: String = ""
    
    var body: some View {
        
        VStack(spacing: 25) {
             
            Text("Change-the-default-percentage".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
            
            TextField("Default-%".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), text: $text)
                .keyboardType(.numberPad)
                .textFieldStyle(.plain)
                .font(.system(size: 48, weight: .heavy))
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
            
            Button("Set-the-value".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)) {
                print("Button pressed!")
                
            }
            .buttonStyle(GrowingButton())
            
        }
        // Maximum height = 390
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 390)
        .background(.modeBG)
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal, 15)
        
    }
    
}

struct GrowingButton: ButtonStyle {
    
    let exampleColor: Color = Color(red: 84/255, green: 134/255, blue: 241/255)
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .padding()
            .background(exampleColor)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        
    }
    
}

#Preview {
    SettingsSwiftUIView()
}
