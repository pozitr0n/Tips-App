//
//  TipsCalulatorViewController.swift
//  Tips
//
//  Created by Raman Kozar on 11/03/2024.
//

import UIKit
import SwiftUI
import Combine

class TipsCalulatorViewController: UIViewController {
    
    var vcTipsCalulator: UIHostingController<AnyView>?
    private var valObject = ValuesObject()
    private var cancellable: AnyCancellable?
    
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var addToFavourite: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeInterface()
        loadSwiftUIViewController()
        
    }
    
    func localizeInterface() {
        
        share.title             = Localize(key: "QAb-0s-j0x.title", comment: "")
        refresh.title           = Localize(key: "gk0-cT-5Rs.title", comment: "")
        addToFavourite.title    = Localize(key: "Tyb-Nx-A4j.title", comment: "")
        
    }
    
    func loadSwiftUIViewController() {
               
        vcTipsCalulator = UIHostingController(rootView: AnyView(ValuesViewContainer(valObject: valObject)))
        
        guard let vcTipsCalulator = vcTipsCalulator,
              let swiftuiView = vcTipsCalulator.view else { return }
    
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the view controller to the destination view controller.
        self.addChild(vcTipsCalulator)
        self.view.addSubview(swiftuiView)
        
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Notify the child view controller that the move is complete.
        vcTipsCalulator.didMove(toParent: self)
        
    }
    
    @IBAction func refreshView(_ sender: Any) {
        
        // Refresh view/data/all information
        //
        cancellable = valObject.$value.sink(receiveValue: { value in
            
            let currentValue = ValuesForCalculations().getDoubleCount(value: value, maximumFractionDigits: 2)
            
            if currentValue != 0 {
                
                let alert = UIAlertController(title: "Alert-Refreshing.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), message: "Alert-Refreshing.message".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Alert-Refreshing.primaryButton".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), style: .default, handler: { action in
                    
                    self.valObject.value = 0
                    
                    self.vcTipsCalulator = UIHostingController(rootView: AnyView(ValuesViewContainer(valObject: self.valObject)))
                    
                    guard let vcTipsCalulator = self.vcTipsCalulator,
                          let swiftuiView = vcTipsCalulator.view else { return }
                
                    swiftuiView.translatesAutoresizingMaskIntoConstraints = false
                    
                    // Add the view controller to the destination view controller.
                    self.addChild(vcTipsCalulator)
                    self.view.addSubview(swiftuiView)
                    
                    // Create and activate the constraints for the swiftui's view.
                    NSLayoutConstraint.activate([
                        swiftuiView.topAnchor.constraint(equalTo: self.view.topAnchor),
                        swiftuiView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                        swiftuiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                        swiftuiView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                    ])
                    
                    // Notify the child view controller that the move is complete.
                    vcTipsCalulator.didMove(toParent: self)
                    
                }))
                alert.addAction(UIAlertAction(title: "Alert-Refreshing.cancelButton".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), style: UIAlertAction.Style.cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
        })
        
    }
    
    @IBAction func addToFavourite(_ sender: Any) {
        
        // adding to favourite (realm database)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vcShare = segue.destination as? ShareViewController {
            
            var formatterOfNumber: FormatterNumberProtocol = NumberFormatter()
            
            formatterOfNumber.numberStyle = .currency
            formatterOfNumber.maximumFractionDigits = 2
            formatterOfNumber.locale = CurrentLocale.shared.currentLocale
            
            vcShare.valueDouble = TipsCalculations().calculateBillSummary(
                startSum: ValuesForCalculations().getDoubleCount(value: valObject.value,
                                                                 maximumFractionDigits: formatterOfNumber.maximumFractionDigits)
            )
            
            vcShare.tipDouble = TipsCalculations().calculateTipSummary(
                startSum: ValuesForCalculations().getDoubleCount(value: valObject.value,
                                                                 maximumFractionDigits: formatterOfNumber.maximumFractionDigits),
                percent: valObject.percent
            )
            
            vcShare.tipPercent = valObject.percent
            vcShare.numberOfPersonsInt = valObject.numberOfPersons
            
            vcShare.eachPayDouble = TipsCalculations().calculateTotalPerPerson(
                startSum: ValuesForCalculations().getDoubleCount(value: valObject.value, 
                                                                 maximumFractionDigits: formatterOfNumber.maximumFractionDigits), percent: valObject.percent,
                numberOfPersons: valObject.numberOfPersons
            )
            
        }
        
    }
    
}

