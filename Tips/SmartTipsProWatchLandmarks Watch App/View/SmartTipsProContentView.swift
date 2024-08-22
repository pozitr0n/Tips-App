//
//  ContentView.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 29/07/2024.
//

import SwiftUI

struct SmartTipsProContentView: View {

    @EnvironmentObject private var currentModel: SmartTipsProWatchModel
    @State var showingBillInputView = false
    
    var body: some View {
        
        ScrollView {
            
            // Bill tips
            HStack(alignment: .center) {
                
                Image("icon-bill-applewatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .font(.title2)
                Spacer()
                    .frame(width: UI_Constants.shared.imageSpacerWidth)
                Text("Bill")
                    .font(.title3)
                Spacer()
                
            }
            
            HStack() {
                
                if (currentModel.billTips == "") {
                    Button(action: { showingBillInputView.toggle() }) {
                        Text("0.00")
                    }
                } else {
                    Button(action: { showingBillInputView.toggle() }) {
                        Text(currentModel.billTips)
                    }
                }
                
            }
            .font(.title2)
            .padding(.bottom)
            
            // Amount of people (dividing the bill)
            HStack(alignment: .center) {
                
                Image("icon-persons-applewatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .font(.title2)
                
                Spacer()
                    .frame(width: UI_Constants.shared.imageSpacerWidth)
                
                Text("People")
                    .font(.title3)
                
                Spacer()
                
                if (currentModel.amountOfPeople == "") {
                    Text("1")
                        .font(.title3)
                } else {
                    Text(currentModel.amountOfPeople)
                        .font(.title3)
                }
                
            }
            
            HStack {
                
                Button(action: {
                    currentModel.decrementingAmountOfPeople()
                }) {
                    Image(systemName: "minus")
                        .font(.title3)
                }
                .disabled(!currentModel.decrementingAmountOfPeopleEnabled())
                
                Button(action: {
                    currentModel.incrementingAmountOfPeople()
                }) {
                    Image(systemName: "plus")
                        .font(.title3)
                }
                .disabled(!currentModel.incrementingAmountOfPeopleEnabled())
                
            }
            .padding(.bottom)
            
            // Calculating tips - percent
            HStack(alignment: .center) {
                
                Image("icon-tips-applewatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .font(.title2)
               
                Spacer()
                    .frame(width: UI_Constants.shared.imageSpacerWidth)
                
                Text("Quick Tips")
                    .font(.title3)
                
                Spacer()
                
                Text(String(format:"%0.0f%%", currentModel.percentOfTips))
                    .font(.title3)
                
            }
            Slider(value: $currentModel.percentOfTips, in: 0...100, step: 1)
                .padding(.bottom)
            
            // Output information
            Group {
                
                OutputView(label: "Tip", value: currentModel.amountOfTips, format: "%0.2f")
                OutputView(label: "Each", value: currentModel.amountPerPerson, format: "%0.2f")
                OutputView(label: "Total", value: currentModel.totalBill, format: "%0.2f")
                
            }
            
            Button(action: {
                print("test")
            }) {
                Image(systemName: "folder.circle")
                    .font(.title3)
                Image(systemName: "arrow.forward")
                    .font(.title3)
                Image(systemName: "iphone.circle")
                    .font(.title3)
            }
            .colorMultiply(.controlBackground)
            
        }
        .fullScreenCover(isPresented: $showingBillInputView) {
            SmartTipsProDecimalPad(currentText: $currentModel.billTips)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.1)
        
    }
    
}

struct SmartTipsProContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        SmartTipsProContentView()
            .environmentObject(SmartTipsProWatchModel())
    }
    
}
