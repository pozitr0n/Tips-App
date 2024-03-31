//
//  DetailLanguages.swift
//  Tips
//
//  Created by Raman Kozar on 25/03/2024.
//

import SwiftUI

struct DetailLanguages: View {
    
    @State var languages: [LanguageObject]
    @State var selectedLanguage: LanguageOptions = CurrentLanguage.shared.currentLanguage
    
    var body: some View {
        
        Form {
            
            List($languages) { $lang in
                SelectionLanguageCell(currentLanguage: lang.language, selectedLanguage: self.$selectedLanguage)
            }
            
        }
        .onAppear {
            selectedLanguage = CurrentLanguage.shared.currentLanguage
        }
        .navigationTitle("Language-Choose.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
        
    }
    
}

struct SelectionLanguageCell: View {

    let currentLanguage: String
    @Binding var selectedLanguage: LanguageOptions
    @State private var showingAlert = false
    
    var body: some View {
        
        HStack {
            
            Text(currentLanguage)
            Spacer()
            if currentLanguage == selectedLanguage.rawValue {
                Image(systemName: "checkmark")
            }
            
        }
        .background(.modeBG)
        .onTapGesture {
            showingAlert = true
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Change-Language-Alert.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                message: Text("Change-Language-Alert.message".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                primaryButton: .default(Text("Change-Language.primaryButton".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                    
                    self.selectedLanguage = LanguagesUISettings().getLanguageByName(self.currentLanguage)
                    self.saveLanguageToUserDefaults()
                    
                },
                secondaryButton: .cancel(Text("Cancel-Language-Alert.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)))
            )
        }
        
    }
    
    func saveLanguageToUserDefaults() {
        
        Languages().setCurrentLanguage(lang: self.selectedLanguage)
        
        //  Reload application bundle as new selected language
        DispatchQueue.main.async(execute: {
        
            let scene = UIApplication.shared.connectedScenes.first
            if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.initRootView(true)
            }
            
        })
    
    }
    
}

struct LanguageObject: Identifiable {
    let id = UUID()
    let language: String
    var isOn: Bool
}

#Preview {
    SettingsSwiftUIView()
}
