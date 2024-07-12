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

class ValuesObject: ObservableObject {
    @Published var value: Int = 0
    @Published var percent: Double = 0.00
    @Published var numberOfPersons: Int = 1
}

struct ValuesViewContainer: View {
    
    @ObservedObject var valObject: ValuesObject
    
    var body: some View {
        TipsCalulatorUI(valueNew: $valObject.value, percentNew: $valObject.percent, numberOfPersonsNew: $valObject.numberOfPersons)
    }
    
}

// Main struct of main screen UI - TipsCalulatorUI
//
struct TipsCalulatorUI: View {
        
    // values for calculations of the tips
    @Binding var value: Int
    
    @State var percent: Double = CurrentPercentage.shared.currentPercentage == 0 ? 0.00 : Double(CurrentPercentage.shared.currentPercentage)
    @State var numberOfPersons: Int = 1
    
    @Binding var percentFixed: Double
    @Binding var numberOfPersonsFixed: Int

    var billSummary: Double {
        get {
            return TipsCalculations().calculateBillSummary(startSum: ValuesForCalculations().getDoubleCount(value: value, maximumFractionDigits: formatterOfNumber.maximumFractionDigits))
        }
    }
    
    var tipSummary: Double {
        get {
            return TipsCalculations().calculateTipSummary(startSum: ValuesForCalculations().getDoubleCount(value: value, maximumFractionDigits: formatterOfNumber.maximumFractionDigits), percent: percent)
        }
    }
    
    var totalSummary: Double {
        get {
            return TipsCalculations().calculateTotalSummary(startSum: ValuesForCalculations().getDoubleCount(value: value, maximumFractionDigits: formatterOfNumber.maximumFractionDigits), percent: percent)
        }
    }
    
    var billPerPerson: Double {
        get {
            return TipsCalculations().calculateBillPerPerson(startSum: ValuesForCalculations().getDoubleCount(value: value, maximumFractionDigits: formatterOfNumber.maximumFractionDigits), numberOfPersons: numberOfPersons)
        }
    }
    
    var tipPerPerson: Double {
        get {
            return TipsCalculations().calculateTipPerPerson(startSum: ValuesForCalculations().getDoubleCount(value: value, maximumFractionDigits: formatterOfNumber.maximumFractionDigits), percent: percent, numberOfPersons: numberOfPersons)
        }
    }
    
    var totalPerPerson: Double {
        get {
            return TipsCalculations().calculateTotalPerPerson(startSum: ValuesForCalculations().getDoubleCount(value: value, maximumFractionDigits: formatterOfNumber.maximumFractionDigits), percent: percent, numberOfPersons: numberOfPersons)
        }
    }
    
    // default/calculated values for UI
    @State private var currentVStackSpacing: CGFloat = FactorValuesForMainUI().getVStackSpacing(currentInch: Device.size())
    @State private var currentHStackSpacing: CGFloat = FactorValuesForMainUI().getHStackSpacing(currentInch: Device.size())
    @State private var currentPadding: CGFloat = FactorValuesForMainUI().getCurrentPadding(currentInch: Device.size())
    @State private var currentCurrencyTipsTextFieldHeight: CGFloat = FactorValuesForMainUI().getCurrencyTipsTextFieldHeight(currentInch: Device.size())
    @State private var currentCurrencyTipsMainFont: CGFloat = FactorValuesForMainUI().getCurrencyTipsMainFont(currentInch: Device.size())
    
    private var formatterOfNumber: FormatterNumberProtocol
    
    init(formatterOfNumber: FormatterNumberProtocol = NumberFormatter(), valueNew: Binding<Int>, percentNew: Binding<Double>, numberOfPersonsNew: Binding<Int>) {
        
        self.formatterOfNumber = formatterOfNumber
        self.formatterOfNumber.numberStyle = .currency
        self.formatterOfNumber.maximumFractionDigits = 2
        self.formatterOfNumber.locale = CurrentLocale.shared.currentLocale
        
        self._value = valueNew
        self._percentFixed = percentNew
        self._numberOfPersonsFixed = numberOfPersonsNew
        
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
                        .onReceive(Just(value)) { value in
                            
                            if value == 0 {
                                numberOfPersons = 1
                            }
                            
                        }
                    
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
                                percentFixed = 5.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("10%") {
                                percent = 10.0
                                percentFixed = 10.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("15%") {
                                percent = 15.0
                                percentFixed = 15.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("20%") {
                                percent = 20.0
                                percentFixed = 20.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("25%") {
                                percent = 25.0
                                percentFixed = 25.0
                            }
                            .frame(width: ConstantsFactorValuesForMainUI.shared.scrollViewButtonWidth, height: ConstantsFactorValuesForMainUI.shared.scrollViewButtonHeight)
                            .padding()
                            .foregroundStyle(.textButtonColorBackground)
                            .background(.percentColorBackground)
                            .cornerRadius(20)
                            
                            Button("30%") {
                                percent = 30.0
                                percentFixed = 30.0
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
                        
                        Slider(value: $percent, in: 0...100, step: 1.0, onEditingChanged: { _ in percentFixed = percent })
                            .accentColor(.percentColorBackground)
                        
                        Text("\(percent, specifier: "%.0f")%")
                        
                    }
                    
                }
                .padding([.leading, .trailing], currentPadding)
                
                VStack {
                    TipsStepper(value: $numberOfPersons, sum: $value)
                        .onChange(of: numberOfPersons) {
                            numberOfPersonsFixed = numberOfPersons
                        }
                }
                .padding([.leading, .trailing], currentPadding)
                
                VStack {
                    
                    HStack {
                        
                        VStack(alignment: .center, spacing: -5) {
                            
                            Text("Bill-Summary.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
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
                                    .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
                                    .foregroundStyle(.secondary)
                                Text("Tip-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                    .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
                                    .foregroundStyle(.secondary)
                                Text("Total-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                    .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
                                    .foregroundStyle(.secondary)
                            }
                            
                            VStack(alignment: .trailing) {
                                Text(String(format: "%0.2f", billSummary))
                                    .font(.system(size: currentCurrencyTipsMainFont, weight: .semibold))
                                    .foregroundStyle(.primary)
                                Text(String(format: "%0.2f", tipSummary))
                                    .font(.system(size: currentCurrencyTipsMainFont, weight: .semibold))
                                    .foregroundStyle(.primary)
                                Text(String(format: "%0.2f", totalSummary))
                                    .font(.system(size: currentCurrencyTipsMainFont, weight: .semibold))
                                    .foregroundStyle(.primary)
                            }
                            
                        }
                        
                    }
                    .padding([.leading, .trailing], currentPadding - ConstantsFactorValuesForMainUI.shared.paddingAddingCGFloat)
                    
                    if numberOfPersons > 1 {
                     
                        Divider()
                            .frame(width: 200)

                        HStack {
                            
                            VStack(alignment: .center, spacing: 0) {
                                
                                Text("Per-person.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                    .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
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
                                        .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
                                        .foregroundStyle(.secondary)
                                    Text("Tip-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                        .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
                                        .foregroundStyle(.secondary)
                                    Text("Total-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                        .font(.system(size: currentCurrencyTipsMainFont, weight: .bold))
                                        .foregroundStyle(.secondary)
                                }
                                
                                VStack(alignment: .trailing) {
                                    Text(String(format: "%0.2f", billPerPerson))
                                        .font(.system(size: currentCurrencyTipsMainFont, weight: .semibold))
                                        .foregroundStyle(.primary)
                                    Text(String(format: "%0.2f", tipPerPerson))
                                        .font(.system(size: currentCurrencyTipsMainFont, weight: .semibold))
                                        .foregroundStyle(.primary)
                                    Text(String(format: "%0.2f", totalPerPerson))
                                        .font(.system(size: currentCurrencyTipsMainFont, weight: .semibold))
                                        .foregroundStyle(.primary)
                                }
                                
                            }
                        }
                        .padding([.leading, .trailing], currentPadding - ConstantsFactorValuesForMainUI.shared.paddingAddingCGFloat)
                        .padding(.top, ConstantsFactorValuesForMainUI.shared.paddingAddingCGFloat)
                        
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
    
    TipsCalulatorUI(formatterOfNumber: PreviewNumberFormatter(locale: Locale(identifier: "pl_PL")), valueNew: .constant(0), percentNew: .constant(0.00), numberOfPersonsNew: .constant(0))

}
