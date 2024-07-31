//
//  SmartTipsProDecimalPad.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 31/07/2024.
//

import SwiftUI

struct SmartTipsProDecimalPad: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var currentText: String
    
    var body: some View {
        
        VStack {
            
            Group {
                
                if (currentText.isEmpty) {
                    Text("Enter Bill")
                } else {
                    Text(currentText)
                        .bold()
                }
                
            }
            .padding(.horizontal)

            HStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("1") }) {
                        Text("1")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("2") }) {
                        Text("2")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("3") }) {
                        Text("3")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
            }

            HStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("4") }) {
                        Text("4")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("5") }) {
                        Text("5")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("6") }) {
                        Text("6")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
            }

            HStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("7") }) {
                        Text("7")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("8") }) {
                        Text("8")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    Button(action: { currentText.append("9") }) {
                        Text("9")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
            }
            
            HStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                        .onTapGesture {
                            if (currentText.rangeOfCharacter(from: CharacterSet(charactersIn: ".")) == nil) {
                                currentText.append(".")
                            }
                        }
                    
                    Button(action: {
                        if (currentText.rangeOfCharacter(from: CharacterSet(charactersIn: ".")) == nil) {
                            currentText.append(".")
                        }}) {
                            Text(".")
                                .bold()
                        }
                        .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(UI_Constants.shared.smartTipsProDecimalPadButtonColor)
                    
                    Button(action: {
                        currentText.append("0")
                    }) {
                        Text("0")
                            .bold()
                    }
                    .frame(height: 20)
                    
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 9.0)
                        .foregroundColor(.clear)
                    
                    Button(action: {
                        if (!currentText.isEmpty) {
                            currentText.removeLast()
                        }
                    }) {
                        Image(systemName: "delete.left")
                    }
                    .frame(height: 20)
                    .disabled(currentText.isEmpty)
                    
                }
                
            }
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 9.0)
                    .foregroundColor(.clear)
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                }
                .frame(height: 20)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .buttonStyle(PlainButtonStyle())
        .font(.title3)
        .lineLimit(1)
        .minimumScaleFactor(0.1)
        
    }
    
}

struct SmartTipsProDecimalPad_Previews: PreviewProvider {
    
    static var previews: some View {
        SmartTipsProDecimalPad(currentText: .constant(""))
    }
    
}
