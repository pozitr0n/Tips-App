//
//  ShareViewController.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024
//  Updated by Raman Kozar on 11/06/204
//

import UIKit

class ShareViewController: UIViewController, UISheetPresentationControllerDelegate {

    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUI_Settings()
    
    }
    
    func setUI_Settings() {
     
        view.backgroundColor = .percentColorBackground
        cancelButton.tintColor = .textButtonColorBackground
       
        mainImageView.layer.cornerRadius = 10.0
        mainImageView.clipsToBounds = true
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
