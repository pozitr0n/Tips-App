//
//  ChangeApplicationIcon.swift
//  Tips
//
//  Created by Raman Kozar on 25/03/2024.
//

import SwiftUI

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

struct IconsForChanging: Identifiable {
    let id = UUID()
    var iconName: String?
    var isOn: Bool
}

#Preview {
    SettingsSwiftUIView()
}
