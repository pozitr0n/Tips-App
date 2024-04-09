//
//  MailSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 09/04/2024.
//

import SwiftUI
import UIKit
import MessageUI

typealias MainMailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailSwiftUIView: UIViewControllerRepresentable {
   
    @Environment(\.presentationMode) var presentationMode
    @Binding var supportDataIfEmail: ReviewEmail
    let callback: MainMailViewCallback

    class MainCoordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var data: ReviewEmail
        
        let callback: MainMailViewCallback
        
        init(presentationMode: Binding<PresentationMode>, data: Binding<ReviewEmail>, callback: MainMailViewCallback) {
            
            _presentationMode = presentationMode
            _data = data
            self.callback = callback
            
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            
            if let error = error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }
            
            $presentationMode.wrappedValue.dismiss()
            
        }
        
    }

    func makeCoordinator() -> MainCoordinator {
        MainCoordinator(presentationMode: presentationMode, data: $supportDataIfEmail, callback: callback)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailSwiftUIView>) -> MFMailComposeViewController {
        
        let mvc = MFMailComposeViewController()
        
        mvc.mailComposeDelegate = context.coordinator
        mvc.setSubject(supportDataIfEmail.currentsubject)
        mvc.setToRecipients([supportDataIfEmail.toEmailAddress])
        mvc.setMessageBody(supportDataIfEmail.mainBodyOfTheMail, isHTML: false)
        mvc.accessibilityElementDidLoseFocus()
        
        return mvc
        
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailSwiftUIView>) {
    }
    
}

