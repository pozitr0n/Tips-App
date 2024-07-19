//
//  Icons.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 24/03/2024.
//

import Foundation
import UIKit

final class IconNames: ObservableObject {
    
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        
        getAlternateIcons()
        specialSortingOfArray()
        
        func getAlternateIcons() {
            
            if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String : Any],
               let alternateIcons = icons["CFBundleAlternateIcons"] as? [String : Any] {
                
                for (_, value) in alternateIcons {
                    
                    // icon list
                    guard let iconList = value as? Dictionary<String, Any> else {
                        return
                    }
                    
                    // icon files
                    guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else {
                        return
                    }
                    
                    // icon
                    guard let icon = iconFiles.first else {
                        return
                    }
                    
                    iconNames.append(icon)
                    
                }
                
            }
            
        }
        
        func specialSortingOfArray() {
        
            if iconNames.count != 0 {
                
                let sortedArray = iconNames.sorted { (key, val) -> Bool in
                    
                    switch (key, val) {
                    case let(l?, r?): return l < r
                    case (nil, _): return false
                    case (_?, nil): return true
                        
                    }
                    
                }
                
                iconNames = sortedArray
                
                if let currentIcon = UIApplication.shared.alternateIconName {
                    self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
                }
                
            }
            
        }
        
    }
    
}

class IconsLocal: ObservableObject {
    
    func getAllIcons() -> [IconsForChanging] {
     
        var allIcons: [IconsForChanging] = []
        
        for icon in IconNames().iconNames {
        
            let currentIcon = UIApplication.shared.alternateIconName
            
            let newIcon = IconsForChanging(iconName: icon, isOn: currentIcon == icon)
            allIcons.append(newIcon)
            
            
        }
                
        return allIcons
        
    }
    
}
