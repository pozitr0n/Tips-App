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
        loadSwiftUIViewController()
        
    }
    
    func loadSwiftUIViewController() {
     
        let vcFavourite = UIHostingController(rootView: FavouriteSwiftUIView())
        
        let swiftuiView = vcFavourite.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the view controller to the destination view controller.
        addChild(vcFavourite)
        view.addSubview(swiftuiView)
        
        // Create and activate the constraints for the swiftui's view.
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Notify the child view controller that the move is complete.
        vcFavourite.didMove(toParent: self)
        
    }

}
