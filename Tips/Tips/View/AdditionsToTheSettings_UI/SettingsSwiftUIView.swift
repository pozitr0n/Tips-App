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
    
    // Changing currency format
    @State private var changeCurrency: Bool = false
    
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
                            
                            if array.title == "Currency-format.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                
                                Button(array.title, systemImage: "dollarsign.circle") {
                                    changeCurrency.toggle()
                                }
                                .padding(.trailing)
                                
                            } else if array.title == "Default-Percentage.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                
                                NavigationLink(destination: DetailScreenMoreInfo(moreInfoItem: array))  {
                                 
                                    VStack {
                                        
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
            .sheet(isPresented: $changeCurrency, content: {
                
                CurrencyCodes()
                
                // Since maximum height is 390
                    .presentationDetents([.height(390)])
                    .presentationBackground(.clear)
                    
            })
            .sheet(isPresented: $changeMode, content: {
                
                ModeChangeView(scheme: scheme)
                
                // Since maximum height is 410
                    .presentationDetents([.height(410)])
                    .presentationBackground(.clear)
                    
            })
        }
        
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

struct MoreInfoObject: Identifiable {
    let id = UUID()
    let title: String
}

#Preview {
    SettingsSwiftUIView()
}
