//
//  TipsCalulatorUI.swift
//  Tips
//
//  Created by Raman Kozar on 18/05/2024.
//

import SwiftUI
import Combine
import Foundation

protocol FormatterNumberProtocol: Any {
    
    func string(for obj: Any?) -> String?
    func string(from number: NSNumber) -> String?
    
    var numberStyle: NumberFormatter.Style { get set }
    var maximumFractionDigits: Int { get set }
    var locale: Locale! { get set }
    
}

struct TipsCalulatorUI: View {
    
    @State private var value = 0
    @State private var percent: Double = 0.00
    @State private(set) var numberOfPersons: Int = 0
    
    private var formatterOfNumber: FormatterNumberProtocol
    
    init(formatterOfNumber: FormatterNumberProtocol = NumberFormatter()) {
        
        self.formatterOfNumber = formatterOfNumber
        self.formatterOfNumber.numberStyle = .currency
        self.formatterOfNumber.maximumFractionDigits = 2
        self.formatterOfNumber.locale = CurrentLocale.shared.currentLocale
        
    }

    var body: some View {
    
        VStack(spacing: 30) {
            
            VStack(spacing: 10) {
            
                Text("Bill-Total.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                    .fontWeight(.medium)
                    .font(.system(size: 35))
                    .foregroundStyle(
                        LinearGradient(colors: [.textButtonColorBackground, .textHeader], startPoint: .bottom, endPoint: .top)
                    )
                
                CurrencyTipsTextField(formatterOfNumber: formatterOfNumber, value: $value)
                    .padding(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 3)
                        .frame(width: UIScreen.main.bounds.size.width - 30, height: 70))
                    .frame(width: UIScreen.main.bounds.size.width - 30, height: 70)
                
            }
            
            VStack(spacing: 5) {
            
                Text("Quick-Tips.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                    .fontWeight(.medium)
                    .font(.system(size: 25))
                    .foregroundStyle(
                        LinearGradient(colors: [.textButtonColorBackground, .textHeader], startPoint: .bottom, endPoint: .top)
                    )
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack {
                        
                        Button("5%") {
                            percent = 5.0
                        }
                        .frame(width: 70, height: 8)
                        .padding()
                        .foregroundStyle(.textButtonColorBackground)
                        .background(.percentColorBackground)
                        .cornerRadius(20)
                        
                        Button("10%") {
                            percent = 10.0
                        }
                        .frame(width: 70, height: 8)
                        .padding()
                        .foregroundStyle(.textButtonColorBackground)
                        .background(.percentColorBackground)
                        .cornerRadius(20)
                        
                        Button("15%") {
                            percent = 15.0
                        }
                        .frame(width: 70, height: 8)
                        .padding()
                        .foregroundStyle(.textButtonColorBackground)
                        .background(.percentColorBackground)
                        .cornerRadius(20)
                        
                        Button("20%") {
                            percent = 20.0
                        }
                        .frame(width: 70, height: 8)
                        .padding()
                        .foregroundStyle(.textButtonColorBackground)
                        .background(.percentColorBackground)
                        .cornerRadius(20)
                        
                        Button("25%") {
                            percent = 25.0
                        }
                        .frame(width: 70, height: 8)
                        .padding()
                        .foregroundStyle(.textButtonColorBackground)
                        .background(.percentColorBackground)
                        .cornerRadius(20)
                        
                        Button("30%") {
                            percent = 30.0
                        }
                        .frame(width: 70, height: 8)
                        .padding()
                        .foregroundStyle(.textButtonColorBackground)
                        .background(.percentColorBackground)
                        .cornerRadius(20)
                        
                    }
                    .padding()
                    
                }
                .frame(width: UIScreen.main.bounds.size.width, height: 60)
                
            }
            
            VStack {
            
                HStack(spacing: 10) {
                    Slider(value: $percent, in: 0...100, step: 1.0)
                        .accentColor(.percentColorBackground)
                    Text("\(percent, specifier: "%.0f")%")
                }
                
            }
            
            VStack {
                
                HStack {
                    
                    Text("Number-of-Persons.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                        .fontWeight(.medium)
                        .font(.system(size: 25))
                        .foregroundStyle(
                            LinearGradient(colors: [.textButtonColorBackground, .textHeader], startPoint: .bottom, endPoint: .top)
                        )
                    
                    Spacer()
                    
                    TipsStepper(value: $numberOfPersons)
                    
                }
                
            }
            
            Spacer()
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        
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
