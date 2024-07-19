//
//  SettingsSwiftUIView.swift
//  SmartTipsPro
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
    
    // Changing percentage
    @State private var changePercentage: Bool = false
    
    // Changing the rating
    @State private var changeRating: Bool = false
    
    let blockTheme: [MoreInfoObject] = [
        MoreInfoObject(title: "Application-Icon.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Application-Mode.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
    ]
    
    let blockGeneral: [MoreInfoObject] = [
        MoreInfoObject(title: "Language.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Currency-format.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Default-Percentage.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
    ]
    
    let blockAbout: [MoreInfoObject] = [
        MoreInfoObject(title: "What-New.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Application-Rate.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
        MoreInfoObject(title: "Application-Privacy-Policy.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
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
                                
                                Button(array.title, systemImage: "percent") {
                                    changePercentage.toggle()
                                }
                                .padding(.trailing)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                Section(header: Text("Application-About.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))) {
                    
                    List(blockAbout) { array in
                        
                        if array.title == "What-New.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                            
                            NavigationLink(destination: WhatIsNew()) {
                                
                                VStack {
                                    
                                    Label(array.title, systemImage: "newspaper.circle")
                                        .padding(.trailing)
                                    
                                }
                                
                            }
                            
                        } else {
                            
                            if array.title == "Application-Rate.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                
                                Button(array.title, systemImage: "heart.circle") {
                                    changeRating.toggle()
                                }
                                .padding(.trailing)
                                
                            }
                            
                            if array.title == "Application-Privacy-Policy.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) {
                                
                                Button(array.title, systemImage: "lock.circle") {
                                    
                                    if let url = URL(string: "https://www.privacypolicies.com/live/6a2b1eee-8d08-4c1f-8be1-ad8e68bb35fd") {
                                        UIApplication.shared.open(url)
                                    }
                                    
                                }
                                .padding(.trailing)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                Section {
                    
                    HStack(alignment: .center) {
                        
                        Spacer()
                        
                        VStack(alignment: .center) {
                            
                            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                                .resizable().renderingMode(.original).frame(width: 60, height: 60, alignment: .leading)
                            
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.gray,
                                                                                                       lineWidth: 2))
                            
                            Text("v1.0.1")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            Text("Made-In-By.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            Text("[Raman Kozar🧑🏻‍💻](https://about.me/r.kozar)")
                                .font(.subheadline)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                }
                .listRowBackground(Color.clear)
                
            }
            .navigationTitle("navigationTitlle.Settings.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
            .sheet(isPresented: $changeCurrency, content: {
                
                CurrencyCodes()
                
                // Since maximum height is 390 + 10
                    .presentationDetents([.height(400)])
                    .presentationBackground(.clear)
                
            })
            .sheet(isPresented: $changeMode, content: {
                
                ModeChangeView(scheme: scheme)
                
                // Since maximum height is 410 + 10
                    .presentationDetents([.height(420)])
                    .presentationBackground(.clear)
                
            })
            .sheet(isPresented: $changePercentage, content: {
                
                DefaultPercentage()
                
                // Since maximum height is 350 + 10
                    .presentationDetents([.height(360)])
                    .presentationBackground(.clear)
                
            })
            .sheet(isPresented: $changeRating, content: {
                
                RatingExperience()
                
                // Since maximum height is 150 + 10
                    .presentationDetents([.height(160)])
                    .presentationBackground(.clear)
                
            })
            
        }
        
    }
    
}

struct MoreInfoObject: Identifiable {
    let id = UUID()
    let title: String
}

#Preview {
    SettingsSwiftUIView()
}
