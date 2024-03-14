//
//  SplashPresenter.swift
//  Tips
//
//  Created by Raman Kozar on 13/03/2024.
//

import UIKit

protocol SplashPresenterDescription: AnyObject {
    
    func present()
    func dismiss(completion: @escaping () -> Void)
    
}

final class SplashPresenter: SplashPresenterDescription {
    
    private let scene: UIWindowScene
    
    init(scene: UIWindowScene) {
        self.scene = scene
    }
    
    private lazy var animator: SplashAnimatorDescription = SplashAnimator(foregroundSplashWindow: foregroundSplashWindow,
                                                                          backgroundSplashWindow: backgroundSplashWindow)
    
    private lazy var foregroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(with: textImage, logoIsHidden: false)
        let splashWindow = self.splashWindow(windowLevel: .normal + 1, rootViewController: splashViewController)
        
        return splashWindow
        
    }()
    
    private lazy var backgroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(with: textImage, logoIsHidden: true)
        let splashWindow = self.splashWindow(windowLevel: .normal - 1, rootViewController: splashViewController)
        
        return splashWindow
        
    }()
    
    private lazy var textImage: UIImage? = {
       
        let textCount = 5
        
        // Now only for single language.
        // Later it will be changes here.
        
        let randomNumber = Int.random(in: 1...textCount)
        let imageName = "Text-eng-\(randomNumber)"
        
        return UIImage(named: imageName)
        
    }()
    
    // Method for slpashing window
    //
    private func splashWindow(windowLevel: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
       
        let splashWindow = UIWindow(windowScene: scene)
        
        splashWindow.windowLevel = windowLevel
        splashWindow.rootViewController = rootViewController
        splashWindow.makeKeyAndVisible()
        
        return splashWindow
        
    }
    
    // Method for splashing view controller
    //
    private func splashViewController(with textImage: UIImage?, logoIsHidden: Bool) -> SplashViewController? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
        let splashViewController = viewController as? SplashViewController
        
        splashViewController?.textImage = textImage
        splashViewController?.logoIsHidden = logoIsHidden
        
        return splashViewController
        
    }
    
    // Presenting method
    //
    func present() {
        animator.animateAppearance()
    }
    
    // Dismissing method
    //
    func dismiss(completion: @escaping () -> Void) {
        animator.animateDisappearance(completion: completion)
    }

}
