//
//  CurrencyTipsTextField.swift
//  Tips
//
//  Created by Raman Kozar on 18/05/2024.
//

import Foundation
import SwiftUI

struct CurrencyTipsTextField: UIViewRepresentable {

    typealias UIViewType = CurrencyTipsUITextField

    let formatterOfNumber:  FormatterNumberProtocol
    let currencyField:      CurrencyTipsUITextField

    init(formatterOfNumber: FormatterNumberProtocol, value: Binding<Int>) {
        
        self.formatterOfNumber = formatterOfNumber
        currencyField = CurrencyTipsUITextField(formatter: formatterOfNumber, value: value)
        currencyField.doneButtonOnNumpad()
        
    }

    func makeUIView(context: Context) -> CurrencyTipsUITextField {
        return currencyField
    }

    func updateUIView(_ uiView: CurrencyTipsUITextField, context: Context) { }
    
}
