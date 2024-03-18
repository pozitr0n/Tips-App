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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeInterface()
        
    }
    
    func localizeInterface() {
        
        share.title = Localize(key: "QAb-0s-j0x.title", comment: "")
        refresh.title = Localize(key: "gk0-cT-5Rs.title", comment: "")
        addToFavourite.title = Localize(key: "Tyb-Nx-A4j.title", comment: "")
        
    }

}

