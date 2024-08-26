//
//  Extensions.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 26/08/2024.
//

import Foundation

extension Array where Element: Hashable {
    
    func uniqued() -> Array {
        
        var buffer = Array()
        var added = Set<Element>()
        
        for elem in self {
            
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
            
        }
        
        return buffer
        
    }
    
}

extension String {
    
    // * 1 *
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    // * 1 *
    
}
