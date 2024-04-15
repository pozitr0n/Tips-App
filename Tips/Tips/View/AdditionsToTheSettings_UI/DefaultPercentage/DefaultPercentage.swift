//
//  DefaultPercentage.swift
//  Tips
//
//  Created by Raman Kozar on 01/04/2024.
//

import SwiftUI
import Combine

class NumbersOnly: ObservableObject {
    
    @Published var value = CurrentPercentage.shared.currentPercentage == 0 ? "" : String(CurrentPercentage.shared.currentPercentage) {
        
        didSet {
            
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
            
        }
        
    }
    
}

struct DefaultPercentage: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var input = NumbersOnly()
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            VStack(spacing: 25) {

                Text("Change-the-default-percentage".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) + " (%)")
                
                HStack {
                 
                    TextField("Default-%".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), text: $input.value)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.plain)
                        .font(.system(size: 48, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
                        .onReceive(Just(input.value)) { newValue in
                            
                            if newValue.first == "0" {
                                self.input.value = String(newValue.dropFirst())
                            }
                                                
                        }
                    
                }
                    
                HStack(spacing: 10) {
                
                    Button("Set-the-value".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)) {
                               
                        var intUnwrappingMain: Int = 0
                        
                        if input.value.isEmpty {
                            Percentage().setCurrentPercentage(currentPercentage: intUnwrappingMain)
                            dismiss()
                        }
                        
                        guard let intUnwrapping = Int(input.value) else {
                            return
                        }
                        
                        intUnwrappingMain = intUnwrapping
                        
                        if intUnwrappingMain >= 0 && intUnwrappingMain <= 100 {
                            Percentage().setCurrentPercentage(currentPercentage: intUnwrappingMain)
                            dismiss()
                        }
          
                    }
                    .buttonStyle(GrowingButtonPress())
                    
                    Button {
                        input.value = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .buttonStyle(GrowingButtonClear())
                
                }
                
            }
            // Maximum height = 350
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 350)
            .background(.modeBG)
            .clipShape(.rect(cornerRadius: 30))
            .padding(.horizontal, 15)
         
        }
    
    }
    
}

struct GrowingButtonPress: ButtonStyle {
    
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

struct GrowingButtonClear: ButtonStyle {
    
    let exampleColor: Color = Color(red: 211/255, green: 211/255, blue: 211/255)
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
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
