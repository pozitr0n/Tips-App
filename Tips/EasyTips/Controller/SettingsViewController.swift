//
//  SettingsViewController.swift
//  EasyTips
//
//  Created by Raman Kozar on 14/03/2024.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadSwiftUIViewController()
                
    }
    
    func loadSwiftUIViewController() {
     
        let detailView = SettingsSwiftUIView()
        let vcSettings = UIHostingController(rootView: detailView)
        
        let swiftuiView = vcSettings.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the view controller to the destination view controller.
        addChild(vcSettings)
        view.addSubview(swiftuiView)
        
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Notify the child view controller that the move is complete.
        vcSettings.didMove(toParent: self)
                
    }

}
