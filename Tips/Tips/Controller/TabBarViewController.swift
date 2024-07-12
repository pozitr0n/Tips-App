//
//  TabBarViewController.swift
//  Tips
//
//  Created by Raman Kozar on 14/03/2024.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self
        
        setTabViewControllerParams(index: 0, tabBarItemTitle: Localize(key: "feV-wK-qce.title", comment: ""), navigationItemTitle: Localize(key: "hsB-TO-Q61.title", comment: ""))
        setTabViewControllerParams(index: 1, tabBarItemTitle: Localize(key: "fpD-qQ-uGK.title", comment: ""), navigationItemTitle: "")
        setTabViewControllerParams(index: 2, tabBarItemTitle: Localize(key: "Qq1-zl-SnJ.title", comment: ""), navigationItemTitle: "")
        setTabViewControllerParams(index: 3, tabBarItemTitle: Localize(key: "18x-2K-JfQ.title", comment: ""), navigationItemTitle: "")
        
    }

    func setTabViewControllerParams(index: Int, tabBarItemTitle: String, navigationItemTitle: String) {

        if let tabBarItems = tabBar.items {
            if index < tabBarItems.count {
                tabBarItems[index].title = tabBarItemTitle
            }
        }

        if let viewControllers = viewControllers {
            if index < viewControllers.count {
                if let navigationController = viewControllers[index] as? UINavigationController {
                    if navigationController.viewControllers.count > 0 {
                        let viewController = navigationController.viewControllers[0]
                        viewController.navigationItem.title = navigationItemTitle
                    }
                }
            }
        }
    }
    
}
