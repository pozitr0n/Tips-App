//
//  SceneDelegate.swift
//  Tips
//
//  Created by Raman Kozar on 11/03/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var splashPresenter: SplashPresenterDescription?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let scene = (scene as? UIWindowScene) else { return }
        setupMainSettings(with: scene)
        
    }
    
    // Main setup for application
    //
    private func setupMainSettings(with scene: UIWindowScene) {
        
        Languages().getCurrentLanguage()
        
        splashPresenter = SplashPresenter(scene: scene)
        setupWindow(with: scene)
        initRootView()
        splashPresenter?.present()
        
        let delay: TimeInterval = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
        
    }
    
    // Main setup for UIWindow
    //
    private func setupWindow(with scene: UIScene) {
       
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        self.window?.makeKeyAndVisible()
        
    }
    
    // init() of root view
    //
    func initRootView(_ withAnimation: Bool = false) {
        
        // set appearance of component on basis of language direction
        let semantic: UISemanticContentAttribute = .forceLeftToRight
        
        UITabBar.appearance().semanticContentAttribute          = semantic
        UIView.appearance().semanticContentAttribute            = semantic
        UINavigationBar.appearance().semanticContentAttribute   = semantic
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
           
            if withAnimation {
                Languages().animateChangingLanguage(window: window, tabBarController: tabBarController)
            } else {
                window?.rootViewController = tabBarController
            }
            
        }
        
    }
    
    func changeDarkLightMode(mode: UIUserInterfaceStyle) {
        
        guard let window = window else {
            return
        }
        
        window.overrideUserInterfaceStyle = mode
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

