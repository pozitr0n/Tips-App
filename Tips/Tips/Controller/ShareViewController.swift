//
//  ShareViewController.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024
//  Updated by Raman Kozar on 11/06/204
//

import UIKit
import PassKit

class ShareViewController: UIViewController, UISheetPresentationControllerDelegate {

    var valueDouble: Double = 0.00
    var tipDouble: Double = 0.00
    var tipPercent: Double = 0.00
    var numberOfPersonsInt: Int = 1
    var eachPayDouble: Double = 0.00
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var receiptDateLabel: UILabel!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var eachPayLabel: UILabel!
    
    @IBOutlet weak var subtotalValue: UILabel!
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var peopleValue: UILabel!
    @IBOutlet weak var eachPayValue: UILabel!
    
    @IBOutlet weak var shareButtonMain: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        localizeInterface()
        setUI_Settings()
        fillTheData(value: valueDouble)
        
        let currentDateTime = Date()

        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium

        receiptDateLabel.text = formatter.string(from: currentDateTime)
                    
    }
    
    private func fillTheData(value: Double) {
    
        subtotalValue.text  = "\(String(format: "%0.2f", valueDouble)) \(CurrentCurrency.shared.currentCurrency)"
        tipValue.text       = "\(String(format: "%0.2f", tipDouble)) \(CurrentCurrency.shared.currentCurrency)"
        totalValue.text     = "\(String(format: "%0.2f", valueDouble + tipDouble)) \(CurrentCurrency.shared.currentCurrency)"
        peopleValue.text    = numberOfPersonsInt.string
        eachPayValue.text   = "\(String(format: "%0.2f", eachPayDouble)) \(CurrentCurrency.shared.currentCurrency)"
        
    }
    
    func setUI_Settings() {
     
        view.backgroundColor = .percentColorBackground
        
        mainImageView.layer.cornerRadius = 15.0
        mainImageView.clipsToBounds = true
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
        
        receiptLabel.textColor = .textButtonColorBackground
        receiptDateLabel.textColor = .textButtonColorBackground
        
        subtotalLabel.textColor = .textButtonColorBackground
        tipLabel.textColor = .textButtonColorBackground
        totalLabel.textColor = .textButtonColorBackground
        peopleLabel.textColor = .textButtonColorBackground
        eachPayLabel.textColor = .textButtonColorBackground
        
        subtotalValue.textColor = .textButtonColorBackground
        tipValue.textColor = .textButtonColorBackground
        totalValue.textColor = .textButtonColorBackground
        peopleValue.textColor = .textButtonColorBackground
        eachPayValue.textColor = .textButtonColorBackground
        
        shareButtonMain.backgroundColor = .textButtonColorBackground
        shareButtonMain.tintColor = .percentColorBackground
        shareButtonMain.layer.cornerRadius = 15.0
        shareButtonMain.clipsToBounds = true
                
    }
    
    func localizeInterface() {

        detailsLabel.text   = Localize(key: "3tT-QF-MMy.title", comment: "")
        receiptLabel.text   = Localize(key: "LKO-ZR-Ir4.title", comment: "")
        
        subtotalLabel.text  = Localize(key: "sMR-W3-hJp.title", comment: "")
        tipLabel.text       = Localize(key: "DYB-h6-QW8.title", comment: "") + " (\(String(format: "%.0f", tipPercent))%)"
        totalLabel.text     = Localize(key: "gl0-kh-bjo.title", comment: "")
        peopleLabel.text    = Localize(key: "1EH-gv-upV.title", comment: "")
        eachPayLabel.text   = Localize(key: "qeQ-Lf-lwt.title", comment: "")
        
        shareButtonMain.setTitle(Localize(key: "b1G-Tw-DDZ.title", comment: ""), for: .normal)
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let screen = self.view.screenshot()
       
        // set up activity view controller
        let imageToShare = [screen]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }

}
