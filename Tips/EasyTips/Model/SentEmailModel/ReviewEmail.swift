//
//  ReviewEmail.swift
//  EasyTips
//
//  Created by Raman Kozar on 09/04/2024.
//

import SwiftUI

struct ReviewEmail {
    
    let toEmailAddress: String
    let currentsubject: String
    let mainMessageHeader: String
    var mainBodyOfTheMail: String
    
    mutating func changeBody(changings: String) {
        
        self.mainBodyOfTheMail = """
                                 \(self.mainBodyOfTheMail)
                                 \(changings)
                                 """
        
    }
    
    func sendMailUsingURL(open_URL: OpenURLAction) {
       
        let urlString = "mailto:\(toEmailAddress)?subject=\(currentsubject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(mainBodyOfTheMail.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        open_URL(url) { accepted in
            
            if !accepted {
                print("""
                This device doesn't support e-mail
                \(mainBodyOfTheMail)
                """
                )
            }
            
        }
        
    }
    
}
