//
//  TipsCalulatorViewController.swift
//  Tips
//
//  Created by Raman Kozar on 11/03/2024.
//

import UIKit
import SwiftUI

class TipsCalulatorViewController: UIViewController {
    
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
       
        let vcTipsCalulator = UIHostingController(rootView: TipsCalulatorUI())
        let swiftuiView = vcTipsCalulator.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the view controller to the destination view controller.
        addChild(vcTipsCalulator)
        view.addSubview(swiftuiView)
        
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
        
        // refresh view/data/all information
        // !!!!!
    }
    
    @IBAction func addToFavourite(_ sender: Any) {
        
        // adding to favourite (realm database)
        // !!!!!
        
    }
    
}

