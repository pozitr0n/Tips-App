//
//  FavouriteViewController.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024.
//

import UIKit
import SwiftUI

class FavouriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let vc = UIHostingController(rootView: FavouriteSwiftUIView())
        
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // 2
        // Add the view controller to the destination view controller.
        addChild(vc)
        view.addSubview(swiftuiView)
        
        // 3
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // 4
        // Notify the child view controller that the move is complete.
        vc.didMove(toParent: self)
        
    }

}
