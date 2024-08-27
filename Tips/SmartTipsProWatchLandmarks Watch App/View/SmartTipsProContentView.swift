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
    @State private var showAlert = false
    
    let availableCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }.uniqued()
    }()
    
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
            
            HStack(alignment: .center) {
                
                Image("icon-currency-applewatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .font(.title2)
                Spacer()
                    .frame(width: UI_Constants.shared.imageSpacerWidth)
                Text("Currency")
                    .font(.title3)
                Spacer()
                
            }
            
            HStack() {
                
                Picker("Select Currency", selection: $currentModel.selectedCurrency) {
                    
                    ForEach(availableCurrencies, id: \.self) { currencyCode in
                        
                        let currSymbol = String(describing: smartTipsProWatchModelGetSymbol(forCurrencyCode: currencyCode))
                        
                        if currencyCode != currSymbol
                            && !currSymbol.isEmpty {
                            
                            Text("\(currencyCode) (\(currSymbol))")
                                .tag(currencyCode)
                            
                        } else {
                            
                            Text("\(currencyCode)")
                                .tag(currencyCode)
                            
                        }
                        
                    }
                    
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                
            }
            .font(.title2)
            .padding(.bottom)
            .frame(height: 45)
            
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
                showAlert = currentModel.transferDataTo_iPhone()
            })
            {
                Image(systemName: "folder.circle")
                    .font(.title3)
                Image(systemName: "arrow.forward")
                    .font(.title3)
                Image(systemName: "iphone.circle")
                    .font(.title3)
            }
            .colorMultiply(.controlBackground)
            .alert("There is no data for transfering", isPresented: $showAlert) {
                Button("OK", role: .none) { }
            }
            
        }
        .fullScreenCover(isPresented: $showingBillInputView) {
            SmartTipsProDecimalPad(currentText: $currentModel.billTips)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.1)
        
    }
 
    func smartTipsProWatchModelGetSymbol(forCurrencyCode code: String) -> String {
        
        let locale = NSLocale(localeIdentifier: code)
        
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            
            guard let _newlocale = newlocale.displayName(forKey: .currencySymbol, value: code) else {
                return ""
            }
            
            return _newlocale
            
        }
        
        guard let _newlocale = locale.displayName(forKey: .currencySymbol, value: code) else {
            return ""
        }
        
        return _newlocale
        
    }
    
}

struct SmartTipsProContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        SmartTipsProContentView()
            .environmentObject(SmartTipsProWatchModel())
    }
    
}
