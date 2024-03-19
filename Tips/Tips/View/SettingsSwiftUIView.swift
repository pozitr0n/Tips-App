//
//  SettingsSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 14/03/2024.
//

import SwiftUI
import Foundation

struct SettingsSwiftUIView: View {
    
    @State var allLanguages = LanguagesUISettings().getLanguagesForDetailFormat()
    
    let blockTheme: [TestObject2] = [
        TestObject2(name: "Application-Icon.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), about: ""),
        TestObject2(name: "Application-Mode.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), about: "")
    ]
    
    let blockGeneral: [TestObject2] = [
        TestObject2(name: "Language.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), about: "Language"),
        TestObject2(name: "Currency-format.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), about: "Currency format"),
        TestObject2(name: "Default-Percentage.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage), about: "Default Percentage")
    ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Appearance.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                    
                    List(blockTheme) { array in
                        
                        NavigationLink(destination: DetailScreen2(testItem2: array)) {
                            
                            VStack {
                                
                                if array.name == "Application-Icon.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                    Label(array.name, systemImage: "photo.stack")
                                        .padding(.trailing)
                                }
                                
                                if array.name == "Application-Mode.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                    Label(array.name, systemImage: "moon.circle")
                                        .padding(.trailing)
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
                Section(header: Text("General.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {

                    List(blockGeneral) { array in
                        
                        if array.name == "Language.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                        
                            NavigationLink(destination: DetailLanguages(languages: allLanguages)) {
                                
                                VStack {
                                    
                                    Label(array.name, systemImage: "globe.europe.africa")
                                        .padding(.trailing)
                                    
                                }
                                
                            }
                            
                        } else {
                        
                            NavigationLink(destination: DetailScreen2(testItem2: array)) {
                                
                                VStack {
                                    
                                    if array.name == "Language.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                        Label(array.name, systemImage: "globe.europe.africa")
                                            .padding(.trailing)
                                    }
                                    
                                    if array.name == "Currency-format.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                        Label(array.name, systemImage: "dollarsign.circle")
                                            .padding(.trailing)
                                    }
                                    
                                    if array.name == "Default-Percentage.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                        Label(array.name, systemImage: "percent")
                                            .padding(.trailing)
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
            .navigationTitle("navigationTitlle.Settings.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
            
        }
        
    }
    
}

class LanguagesUISettings: ObservableObject {
    
    func getLanguagesForDetailFormat() -> [LanguageObject] {
     
        var allLanguages: [LanguageObject] = []
        
        for lang in Languages().getArrayOfLanguages() {
        
            let newLanguage = LanguageObject(language: lang.rawValue, 
                                             isOn: lang.rawValue == CurrentLanguage.shared.currentLanguage.rawValue)
            allLanguages.append(newLanguage)
            
        }
        
        return allLanguages
        
    }
    
    func getLanguageByName(_ languageName: String) -> LanguageOptions {
        
        guard let lang = LanguageOptions(rawValue: languageName) else {
            return CurrentLanguage.shared.currentLanguage
        }
        
        return lang
        
    }
    
}

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
            Image(systemName: currentLanguage == selectedLanguage.rawValue ? "checkmark" : "")
        }
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
                secondaryButton: .cancel()
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

struct DetailScreen2: View {
    
    let testItem2: TestObject2
    
    var body: some View {
     
        VStack(alignment: .leading) {
            
            HStack {
                Text(testItem2.name)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            Text(testItem2.about)
                .padding(.top)
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(testItem2.name), displayMode: .inline)
        
    }
    
}

struct LanguageObject: Identifiable {
    
    let id = UUID()
    let language: String
    var isOn: Bool
    
}

struct TestObject2: Identifiable {
    let id = UUID()
    let name: String
    let about: String
}

#Preview {
    SettingsSwiftUIView()
}
