//
//  TipsCalulatorUI.swift
//  Tips
//
//  Created by Raman Kozar on 18/05/2024.
//

import SwiftUI
import Combine
import Foundation
import Device

// FormatterNumberProtocol - main protocol for all the operations of formatterng numbers
//
protocol FormatterNumberProtocol: Any {
    
    func string(for obj: Any?) -> String?
    func string(from number: NSNumber) -> String?
    
    var numberStyle: NumberFormatter.Style { get set }
    var maximumFractionDigits: Int { get set }
    var locale: Locale! { get set }
    
}

// Main struct of main screen UI - TipsCalulatorUI
//
struct TipsCalulatorUI: View {
    
    // values for calculations of the tips
    @State private var value = 0
    @State private var percent: Double = 0.00
    @State private(set) var numberOfPersons: Int = 1
    
    @State private var billSummary: Double = 0.00
    @State private var tipSummary: Double = 0.00
    @State private var totalSummary: Double = 0.00
    
    @State private var billPerPerson: Double = 0.00
    @State private var tipPerPerson: Double = 0.00
    @State private var totalPerPerson: Double = 0.00
    
    // default/calculated values for UI
    @State private var currentVStackSpacing: CGFloat = FactorValuesForMainUI().getVStackSpacing(currentInch: Device.size())
    @State private var currentHStackSpacing: CGFloat = FactorValuesForMainUI().getHStackSpacing(currentInch: Device.size())
    @State private var currentPadding: CGFloat = FactorValuesForMainUI().getCurrentPadding(currentInch: Device.size())
    @State private var currentCurrencyTipsTextFieldHeight: CGFloat = FactorValuesForMainUI().getCurrencyTipsTextFieldHeight(currentInch: Device.size())
    @State private var currentCurrencyTipsMainFont: Font.TextStyle = FactorValuesForMainUI().getCurrencyTipsMainFont(currentInch: Device.size())
    
    private var formatterOfNumber: FormatterNumberProtocol
    
    init(formatterOfNumber: FormatterNumberProtocol = NumberFormatter()) {
        
        self.formatterOfNumber = formatterOfNumber
        self.formatterOfNumber.numberStyle = .currency
        self.formatterOfNumber.maximumFractionDigits = 2
        self.formatterOfNumber.locale = CurrentLocale.shared.currentLocale
        
    }

    var body: some View {
        
        GeometryReader { reader in
            
            VStack(spacing: currentVStackSpacing) {
                
                VStack(spacing: currentVStackSpacing) {
                
                    Text("Bill-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                        .fontWeight(.medium)
                        .font(.system(size: 35))
                        .foregroundStyle(
                            .textButtonColorBackground
                        )
                    
                    CurrencyTipsTextField(formatterOfNumber: formatterOfNumber, value: $value)
                        .padding(currentPadding)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 3)
                            .frame(width: reader.size.width - currentCurrencyTipsTextFieldHeight / 2, height: currentCurrencyTipsTextFieldHeight))
                        .frame(width: reader.size.width - currentCurrencyTipsTextFieldHeight / 2, height: currentCurrencyTipsTextFieldHeight)
                    
                }
                .padding(.top, currentVStackSpacing)
                
                VStack(spacing: currentVStackSpacing) {
                
                    Text("Quick-Tips.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                        .fontWeight(.medium)
                        .font(.system(size: 25))
                        .foregroundStyle(
                            .textButtonColorBackground
                        )
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        // Main LazyHStack with all the percents
                        LazyHStack {
                                
                            Button("5%") {
                                percent = 5.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("10%") {
                                percent = 10.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("15%") {
                                percent = 15.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("20%") {
                                percent = 20.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("25%") {
                                percent = 25.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("30%") {
                                percent = 30.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                        }
                        .padding()
                        
                    }
                    .frame(width: reader.size.width, height: ConstantsFactorValuesForMainUI.shared.scrollViewHeight)
                    
                }
                .padding(.top, currentVStackSpacing)
                
                VStack {
                
                    HStack(spacing: currentHStackSpacing) {
                        Slider(value: $percent, in: 0...100, step: 1.0)
                            .accentColor(.percentColorBackground)
                        Text("\(percent, specifier: "%.0f")%")
                    }
                    
                }
                .padding([.leading, .trailing], currentPadding)
                
                VStack {
                    
                    HStack {
                        
                        Text("Number-of-Persons.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                            .fontWeight(.medium)
                            .font(.system(size: 25))
                            .foregroundStyle(
                                .textButtonColorBackground
                            )
                        
                        Spacer()
                        
                        TipsStepper(value: $numberOfPersons, sum: $value)
                        
                    }
                    
                }
                .padding([.leading, .trailing], currentPadding)
                
                VStack {
                    
                    HStack {
                        
                        VStack {
                            
                            Text("Bill-Summary.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                .bold()
                            Image("icon-bill")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .clipped()
                            
                        }
                        
                        Spacer()
                        
                        HStack(spacing: currentHStackSpacing) {
                            
                            VStack(alignment: .trailing) {
                                Text("Bill-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                    .font(.system(currentCurrencyTipsMainFont, weight: .bold))
                                    .foregroundStyle(.secondary)
                                Text("Tip-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                    .font(.system(currentCurrencyTipsMainFont, weight: .bold))
                                    .foregroundStyle(.secondary)
                                Text("Total-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                    .font(.system(currentCurrencyTipsMainFont, weight: .bold))
                                    .foregroundStyle(.secondary)
                            }
                            
                            VStack(alignment: .trailing) {
                                Text(String(format: "%0.2f", billSummary))
                                    .font(.system(currentCurrencyTipsMainFont, weight: .semibold))
                                    .foregroundStyle(.primary)
                                Text(String(format: "%0.2f", tipSummary))
                                    .font(.system(currentCurrencyTipsMainFont, weight: .semibold))
                                    .foregroundStyle(.primary)
                                Text(String(format: "%0.2f", totalSummary))
                                    .font(.system(currentCurrencyTipsMainFont, weight: .semibold))
                                    .foregroundStyle(.primary)
                            }
                            
                        }
                        
                    }
                    .padding([.leading, .trailing], currentPadding)
                    
                    if numberOfPersons > 1 {
                     
                        Divider()
                        
                        HStack {
                            
                            VStack {
                                
                                Text("Per-person.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                    .bold()
                                HStack {
                                    Image("icon-persons")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                        .clipped()
                                    Text("x \(numberOfPersons)")
                                        .bold()
                                }
                                
                            }
                            
                            Spacer()
                            
                            HStack(spacing: currentHStackSpacing) {
                                
                                VStack(alignment: .trailing) {
                                    Text("Bill-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                        .font(.system(currentCurrencyTipsMainFont, weight: .bold))
                                        .foregroundStyle(.secondary)
                                    Text("Tip-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                        .font(.system(currentCurrencyTipsMainFont, weight: .bold))
                                        .foregroundStyle(.secondary)
                                    Text("Total-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                        .font(.system(currentCurrencyTipsMainFont, weight: .bold))
                                        .foregroundStyle(.secondary)
                                }
                                
                                VStack(alignment: .trailing) {
                                    Text(String(format: "%0.2f", billPerPerson))
                                        .font(.system(currentCurrencyTipsMainFont, weight: .semibold))
                                        .foregroundStyle(.primary)
                                    Text(String(format: "%0.2f", tipPerPerson))
                                        .font(.system(currentCurrencyTipsMainFont, weight: .semibold))
                                        .foregroundStyle(.primary)
                                    Text(String(format: "%0.2f", totalPerPerson))
                                        .font(.system(currentCurrencyTipsMainFont, weight: .semibold))
                                        .foregroundStyle(.primary)
                                }
                                
                            }
                        }
                        .padding([.leading, .trailing], currentPadding)
                        
                    }
                
                }
                
                Spacer()
                
            }
            
        }
    
    }
    
}

class PreviewNumberFormatter: FormatterNumberProtocol {
   
    let formatterOfNumber: NumberFormatter
    
    init(locale: Locale) {
        
        formatterOfNumber = NumberFormatter()
        formatterOfNumber.locale = locale
        
    }
    
    var numberStyle: NumberFormatter.Style {
        
        get {
            return formatterOfNumber.numberStyle
        }
        
        set {
            formatterOfNumber.numberStyle = newValue
        }
        
    }
    
    var maximumFractionDigits: Int {
        
        get {
            return formatterOfNumber.maximumFractionDigits
        }
        
        set {
            formatterOfNumber.maximumFractionDigits = newValue
        }
        
    }
    
    var locale: Locale! {
        
        get {
            return formatterOfNumber.locale
        }
        
        set {
            formatterOfNumber.locale = newValue
        }
        
    }
    
    func string(from number: NSNumber) -> String? {
        return formatterOfNumber.string(from: number)
    }
    
    func string(for obj: Any?) -> String? {
        formatterOfNumber.string(for: obj)
    }
    
}

#Preview {
    
    TipsCalulatorUI(formatterOfNumber: PreviewNumberFormatter(locale: Locale(identifier: "pl_PL")))
    //TipsCalulatorUI()

}
