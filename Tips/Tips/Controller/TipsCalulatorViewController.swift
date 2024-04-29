//
//  TipsCalulatorViewController.swift
//  Tips
//
//  Created by Raman Kozar on 11/03/2024.
//

import UIKit

class TipsCalulatorViewController: UIViewController {
    
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var addToFavourite: UIBarButtonItem!
    @IBOutlet weak var billTotalTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeInterface()
        //  We make a call to our keyboard handling function as soon as the view is loaded
        initializeHideKeyboard()
        
    }
    
    func localizeInterface() {
        
        share.title             = Localize(key: "QAb-0s-j0x.title", comment: "")
        refresh.title           = Localize(key: "gk0-cT-5Rs.title", comment: "")
        addToFavourite.title    = Localize(key: "Tyb-Nx-A4j.title", comment: "")
        billTotalTitle.text     = Localize(key: "f4a-R0-T90.title", comment: "")
        
    }
    
}

extension TipsCalulatorViewController {
    
    func initializeHideKeyboard(){
        
        //  Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        
        //  Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissMyKeyboard(){
        
        //  endEditing causes the view (or one of its embedded text fields) to resign the first responder status
        //  In short - Dismiss the active keyboard
        view.endEditing(true)
        
    }
    
}

