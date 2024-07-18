//
//  SplashAnimator.swift
//  EasyTips
//
//  Created by Raman Kozar on 14/03/2024.
//

import UIKit
import QuartzCore

protocol SplashAnimatorDescription: AnyObject {
    func animateAppearance()
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator: SplashAnimatorDescription {
        
    private unowned let foregroundSplashWindow: UIWindow
    private unowned let backgroundSplashWindow: UIWindow
    
    private unowned let foregroundSplashViewController: SplashViewController
    private unowned let backgroundSplashViewController: SplashViewController
        
    // Initialization
    //
    init(foregroundSplashWindow: UIWindow, backgroundSplashWindow: UIWindow) {
       
        self.foregroundSplashWindow = foregroundSplashWindow
        self.backgroundSplashWindow = backgroundSplashWindow
        
        guard
            let foregroundSplashViewController = foregroundSplashWindow.rootViewController as? SplashViewController,
            let backgroundSplashViewController = backgroundSplashWindow.rootViewController as? SplashViewController else {
                fatalError("Splash window doesn't have splash root view controller!")
        }
        
        self.foregroundSplashViewController = foregroundSplashViewController
        self.backgroundSplashViewController = backgroundSplashViewController
        
    }
        
    // Appearance method
    //
    func animateAppearance() {
        
        foregroundSplashWindow.isHidden = false
        
        foregroundSplashViewController.textImageView.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: 0.6, animations: {
            self.foregroundSplashViewController.logoImageView.transform = CGAffineTransform(scaleX: 110 / 100, y: 110 / 100)
            self.foregroundSplashViewController.textImageView.transform = .identity
        })
        
        foregroundSplashViewController.textImageView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.foregroundSplashViewController.textImageView.alpha = 1
        })
        
    }
        
    // Disappearance method
    //
    func animateDisappearance(completion: @escaping () -> Void) {
        
        if let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = currentScene.windows.first {
            
            // Background splash window provides splash behind the animated logo image instead of black screen
            backgroundSplashWindow.isHidden = false
            foregroundSplashWindow.alpha = 0
            
            // This mask provides hole in window with shape of logo image
            let mask = CALayer()
            mask.frame = foregroundSplashViewController.logoImageView.frame
            mask.contents = SplashViewController.logoImageBig.cgImage
            mainWindow.layer.mask = mask
            
            // Fading logo image
            let maskBackgroundView = UIImageView(image: SplashViewController.logoImageBig)
            maskBackgroundView.frame = mask.frame
            mainWindow.addSubview(maskBackgroundView)
            mainWindow.bringSubviewToFront(maskBackgroundView)
            
            CATransaction.setCompletionBlock {
                mainWindow.layer.mask = nil
                completion()
            }
            
            CATransaction.begin()
            
            mainWindow.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            UIView.animate(withDuration: 1.2, animations: {
                mainWindow.transform = .identity
            })
            
            [mask, maskBackgroundView.layer].forEach { layer in
                addScalingAnimation(to: layer, duration: 1.2)
                addRotationAnimation(to: layer, duration: 1.2)
            }
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: [], animations: {
                maskBackgroundView.alpha = 0
            }) { _ in
                maskBackgroundView.removeFromSuperview()
            }
            
            UIView.animate(withDuration: 0.6) {
                self.backgroundSplashViewController.textImageView.alpha = 0
            }
            
            CATransaction.commit()
            
        }
        
    }

    // Adding rotation animation
    //
    private func addRotationAnimation(to layer: CALayer, duration: TimeInterval, delay: CFTimeInterval = 0) {
        
        let animation = CABasicAnimation()
        
        let tangent = layer.position.y / layer.position.x
        let angle = -1 * atan(tangent)

        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.valueFunction = CAValueFunction(name: CAValueFunctionName.rotateZ)
        animation.fromValue = 0
        animation.toValue = angle
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        layer.add(animation, forKey: "transform")
        
    }
    
    // Adding scaling animation
    //
    private func addScalingAnimation(to layer: CALayer, duration: TimeInterval, delay: CFTimeInterval = 0) {
        
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        
        let width = layer.frame.size.width
        let height = layer.frame.size.height
        let coefficient: CGFloat = 18 / 667
        let finalScale = UIScreen.main.bounds.height * coefficient
        let scales = [1, 0.85, finalScale]
        
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.keyTimes = [0, 0.2, 1]
        
        animation.values = scales.map {
            NSValue(cgRect: CGRect(x: 0, y: 0, width: width * $0, height: height * $0))
        }
        
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                     CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        layer.add(animation, forKey: "scaling")
        
    }
    
}
