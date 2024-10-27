//
//  ContentView.swift
//  SmartTipsProWatchLandmarks Watch App
//
//  Created by Raman Kozar on 29/07/2024.
//

import SwiftUI

struct SmartTipsProContentView: View {

    @EnvironmentObject var currentModel: SmartTipsProWatchModel
    
    @State var showingBillInputView = false
    @State private var showAlert = false
    @State private var showSucsessAlert = false
    
    let availableCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }.uniqued()
    }()
    
    @State private var showingLanguagesView = false
    @State private var showingInfoView = false
    
    @State private var scale: CGFloat = 0.3
    @State private var opacity: Double = 0.0
    @State private var rotation: Double = 0.0
    @State private var showMainContent = false
    
    var body: some View {
    
        if !showMainContent {
         
            VStack {
                
                Image("icon-tips-applewatch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .rotationEffect(.degrees(rotation))
                    .opacity(opacity)
                    .onAppear {
                       
                        // Start the animation of the increase, rotation and fade in
                        withAnimation(.easeInOut(duration: 1.5)) {
                            scale = 1.0
                            opacity = 1.0
                        }
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            rotation = 360
                        }
                        
                    }
                
                Text("Welcome-to-Smart-Tips-Pro".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
                    .font(.headline)
                    .opacity(opacity)
                    .onAppear {
                        // Add a small delay to the text
                        withAnimation(.easeInOut(duration: 5.0).delay(1.0)) {
                            opacity = 1.0
                        }
                    }
                
            }
            .onAppear {
                
                // Switch to main screen after animation ends
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                    withAnimation {
                        showMainContent = true
                    }
                }
                
            }
            
        }
        
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
                Text("Bill-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
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
                Text("Currency-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
                    .font(.title3)
                Spacer()
                
            }
            
            HStack() {
                
                Picker("Select-Currency-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage), selection: $currentModel.selectedCurrency) {
                    
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
                
                Text("People-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
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
                
                Text("Quick-Tips-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
                    .font(.title3)
                
                Spacer()
                
                Text(String(format:"%0.0f%%", currentModel.percentOfTips))
                    .font(.title3)
                
            }
            Slider(value: $currentModel.percentOfTips, in: 0...100, step: 1)
                .padding(.bottom)
            
            // Output information
            Group {
                
                OutputView(label: "Tip-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage), value: currentModel.amountOfTips, format: "%0.2f")
                OutputView(label: "Each-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage), value: currentModel.amountPerPerson, format: "%0.2f")
                OutputView(label: "Total-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage), value: currentModel.totalBill, format: "%0.2f")
                
            }
            
            Button(action: {
                showAlert = currentModel.transferDataTo_iPhone()
                showSucsessAlert = !showAlert
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
            .alert("No-Transfer-Message.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage), isPresented: $showAlert) {
                Button("OK", role: .none) { }
            }
            .alert("Sucsess-Transfer-Message.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage), isPresented: $showSucsessAlert) {
                Button("OK", role: .none) { }
            }
            
            Button(action: {
                showingLanguagesView.toggle()
            }) {
                Image(systemName: "globe")
                    .font(.title3)
                Text("Language-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
                    .font(.title3)
                .cornerRadius(8)
            }
            .colorMultiply(.controlBackground)
            .sheet(isPresented: $showingLanguagesView) {
                LanguagesView()
            }
            
            Button(action: {
                showingInfoView.toggle()
            }) {
                Image(systemName: "info.circle")
                    .font(.title3)
                Text("Info-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
                    .font(.title3)
                .cornerRadius(8)
            }
            .colorMultiply(.controlBackground)
            .sheet(isPresented: $showingInfoView) {
                InfoView()
            }
            
        }
        .onChange(of: showingLanguagesView) {
            AppleWatchModelLanguages().getCurrentLanguage()
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

struct LanguagesView: View {
    
    let languagesDict = AppleWatchModelLanguages().languagesCodesWithValues
    
    @State var selectedLanguage = AppleWatchModelLanguages().languagesValuesWithCodes[AppleWatchCurrentLanguage.shared.currentLanguage.rawValue]!
    
    var body: some View {
        
        NavigationView {
            
            List(languagesDict.keys.sorted(), id: \.self) { key in
                
                HStack {
                    
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                    Text(languagesDict[key] ?? key)
                    
                    Spacer()
                    
                    if key == selectedLanguage {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        
                        selectedLanguage = key
                        saveSelectedLanguage()
                        
                    }
                }
            }
            .navigationTitle("Language-AppleWatch.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
        }
        .onAppear {
            AppleWatchModelLanguages().getCurrentLanguage()
        }
        
    }
    
    func saveSelectedLanguage() {
        
        guard let selectedLanguageString = languagesDict[selectedLanguage] else {
            return
        }
        
        AppleWatchModelLanguages().setCurrentLanguage(lang: AppleWatchModelLanguages().getLanguageByName(selectedLanguageString))
        
    }
    
}

struct InfoView: View {
    
    var body: some View {
    
        VStack(alignment: .center) {
            
            Image("icon-tips-applewatch")
                .resizable().renderingMode(.original).frame(width: 60, height: 60, alignment: .leading)
            
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.gray,
                                                                                       lineWidth: 2))
            
            Text("iOS v1.0.5")
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text("watchOS v1.2")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            Spacer()
            
            Text("Made-In-By.title".appleWatchLocalizedSwiftUI(AppleWatchCurrentLanguage.shared.currentLanguage))
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text("Raman Kozar🧑🏻‍💻")
                .font(.subheadline)
            
        }
        
    }
    
}

struct SmartTipsProContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        SmartTipsProContentView()
            .environmentObject(SmartTipsProWatchModel())
    }
    
}
