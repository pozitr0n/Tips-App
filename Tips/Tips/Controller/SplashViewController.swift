//
//  SplashViewController.swift
//  Tips
//
//  Created by Raman Kozar on 13/03/2024.
//

import UIKit

final class SplashViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    
    var logoIsHidden: Bool = false
    var textImage: UIImage?
    
    static let logoImageBig: UIImage = UIImage(named: "icons8-donate-128")!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textImageView.image = textImage
        logoImageView.isHidden = logoIsHidden
        
    }

}
