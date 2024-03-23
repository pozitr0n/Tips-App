//
//  SettingsSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 14/03/2024.
//

import SwiftUI
import Foundation

struct SettingsSwiftUIView: View {
    
    // View properties
    //
    
    // Languages
    @State var allLanguages = LanguagesUISettings().getLanguagesForDetailFormat()
    
    // Icons
    @State var allIcons = IconsLocal().getAllIcons()
    
    // Changing mode of application
    @State private var changeMode: Bool = false
    @AppStorage("userTheme") private var userTheme: Mode = .systemDefaultMode
    @Environment(\.colorScheme) private var scheme
    
    let blockTheme: [MoreInfoObject] = [
        MoreInfoObject(title: "Application-Icon.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Application-Mode.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
    ]
    
    let blockGeneral: [MoreInfoObject] = [
        MoreInfoObject(title: "Language.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Currency-format.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Default-Percentage.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
    ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Appearance.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                    
                    List(blockTheme) { array in
                        
                        if array.title == "Application-Mode.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                            
                            Button(array.title, systemImage: "moon.circle") {
                                changeMode.toggle()
                            }
                            .padding(.trailing)
                                                        
                        } else {
                        
                            NavigationLink(destination: ChangeApplicationIcon(iconsForChanging: allIcons)) {
                                
                                VStack {
                                    
                                    if array.title == "Application-Icon.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                        Label(array.title, systemImage: "photo.stack")
                                            .padding(.trailing)
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    .preferredColorScheme(userTheme.colorScheme)
                    .sheet(isPresented: $changeMode, content: {
                        
                        ModeChangeView(scheme: scheme)
                        
                        // Since maximum height is 410
                            .presentationDetents([.height(410)])
                            .presentationBackground(.clear)
                            
                    })
                                        
                }
                
                Section(header: Text("General.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {

                    List(blockGeneral) { array in
                        
                        if array.title == "Language.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                        
                            NavigationLink(destination: DetailLanguages(languages: allLanguages)) {
                                
                                VStack {
                                    
                                    Label(array.title, systemImage: "globe.europe.africa")
                                        .padding(.trailing)
                                    
                                }
                                
                            }
                            
                        } else {
                        
                            NavigationLink(destination: DetailScreenMoreInfo(moreInfoItem: array)) {
                                
                                VStack {
                                    
                                    if array.title == "Currency-format.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                        Label(array.title, systemImage: "dollarsign.circle")
                                            .padding(.trailing)
                                    }
                                    
                                    if array.title == "Default-Percentage.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                        Label(array.title, systemImage: "percent")
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

class IconsLocal: ObservableObject {
    
    func getAllIcons() -> [IconsForChanging] {
     
        var allIcons: [IconsForChanging] = []
        
        for icon in IconNames().iconNames {
        
            let currentIcon = UIApplication.shared.alternateIconName
            
            let newIcon = IconsForChanging(iconName: icon, isOn: currentIcon == icon)
            allIcons.append(newIcon)
            
            
        }
                
        return allIcons.sorted(by: { $0.id > $1.id })
        
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

struct ChangeApplicationIcon: View {
    
    @State var iconsForChanging: [IconsForChanging]
    
    var body: some View {
        
        Form {
        
            List($iconsForChanging) { $icon in
                
                HStack {
                    
                    Text("\(icon.iconName ?? "Default.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)) Tips Logo")
                    
                    Spacer()
                    
                    Image(uiImage: UIImage(named: icon.iconName ?? "AppIcon") ?? UIImage())
                        .resizable().renderingMode(.original).frame(width: 60, height: 60, alignment: .leading)
                        
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(icon.isOn ? Color.blue : Color.gray, 
                                                                                               lineWidth: icon.isOn ? 5 : 2))
                    
                }
                .background(.modeBG)
                .onTapGesture {
                    
                    UIApplication.shared.setAlternateIconName(icon.iconName)
                    
                    //  Reload application bundle as new selected language
                    DispatchQueue.main.async(execute: {
                    
                        let scene = UIApplication.shared.connectedScenes.first
                        if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
                            sd.initRootView(true)
                        }
                        
                    })
                    
                }
                
            }
            
        }
        .navigationTitle("Application-Mode-Main-Screen.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
        
    }
    
}

struct DetailScreenMoreInfo: View {
    
    let moreInfoItem: MoreInfoObject
    
    var body: some View {
     
        VStack(alignment: .leading) {
            
            HStack {
                Text(moreInfoItem.title)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(moreInfoItem.title), displayMode: .inline)
        
    }
    
}

struct LanguageObject: Identifiable {
    let id = UUID()
    let language: String
    var isOn: Bool
}

struct MoreInfoObject: Identifiable {
    let id = UUID()
    let title: String
}

struct IconsForChanging: Identifiable {
    let id = UUID()
    var iconName: String?
    var isOn: Bool
}

#Preview {
    SettingsSwiftUIView()
}
