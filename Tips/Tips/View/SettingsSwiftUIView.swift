//
//  SettingsSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 14/03/2024.
//

import SwiftUI

struct SettingsSwiftUIView: View {
    
    @State var allLanguages = LanguagesUISettings().getLanguagesForDetailFormat()
    
    let blockTheme: [TestObject2] = [
        TestObject2(name: "Application Icon", about: "App Icon"),
        TestObject2(name: "Application Mode", about: "App Mode")
    ]
    
    let blockGeneral: [TestObject2] = [
        TestObject2(name: "Language", about: "Language"),
        TestObject2(name: "Current format", about: "Current format"),
        TestObject2(name: "Default Percentage", about: "Default Percentage")
    ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Theme")) {
                    
                    List(blockTheme) { array in
                        
                        NavigationLink(destination: DetailScreen2(testItem2: array)) {
                            
                            VStack {
                                
                                if array.name == "Application Icon" {
                                    Label(array.name, systemImage: "photo.stack")
                                        .padding(.trailing)
                                }
                                
                                if array.name == "Application Mode" {
                                    Label(array.name, systemImage: "moon.circle")
                                        .padding(.trailing)
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
                Section(header: Text("General")) {

                    List(blockGeneral) { array in
                        
                        if array.name == "Language" {
                        
                            NavigationLink(destination: DetailLanguages(languages: allLanguages)) {
                                
                                VStack {
                                    
                                    Label(array.name, systemImage: "globe.europe.africa")
                                        .padding(.trailing)
                                    
                                }
                                
                            }
                            
                        } else {
                        
                            NavigationLink(destination: DetailScreen2(testItem2: array)) {
                                
                                VStack {
                                    
                                    if array.name == "Language" {
                                        Label(array.name, systemImage: "globe.europe.africa")
                                            .padding(.trailing)
                                    }
                                    
                                    if array.name == "Current format" {
                                        Label(array.name, systemImage: "dollarsign.circle")
                                            .padding(.trailing)
                                    }
                                    
                                    if array.name == "Default Percentage" {
                                        Label(array.name, systemImage: "percent")
                                            .padding(.trailing)
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
            .navigationTitle(Localize(key: "navigationTitlle.Settings.title", comment: ""))
            
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
        .navigationTitle(Localize(key: "navigationTitlle.Settings.title", comment: ""))
        
    }
    
}

struct SelectionLanguageCell: View {

    let currentLanguage: String
    @Binding var selectedLanguage: LanguageOptions

    var body: some View {
        
        HStack {
            Text(currentLanguage)
            Spacer()
            Image(systemName: currentLanguage == selectedLanguage.rawValue ? "checkmark" : "")
        }
        .onTapGesture {
            self.selectedLanguage = LanguagesUISettings().getLanguageByName(self.currentLanguage)
            self.saveLanguageToUserDefaults()
        }
        
    }
    
    func saveLanguageToUserDefaults() {
        
        Languages().setCurrentLanguage(lang: self.selectedLanguage)
        
        //  Reload application bundle as new selected language
        DispatchQueue.main.async(execute: {
        
            let scene = UIApplication.shared.connectedScenes.first
            if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.initRootView()
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
