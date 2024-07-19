//
//  WhatIsNew.swift
//  SmartTipsPro
//
//  Created by Raman Kozar on 10/04/2024.
//

import SwiftUI

struct WhatIsNew: View {
    
    // Add all the new information about the logic of the application
    //
    @State var whatIsNewArray: [WhatIsNewObject] = [WhatIsNewObject(whatNew: "WhatIsNewObject-Item-1".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                                                    WhatIsNewObject(whatNew: "WhatIsNewObject-Item-2".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                                                    WhatIsNewObject(whatNew: "WhatIsNewObject-Item-3".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                                                    WhatIsNewObject(whatNew: "WhatIsNewObject-Item-4".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                                                    WhatIsNewObject(whatNew: "WhatIsNewObject-Item-5".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                                                    WhatIsNewObject(whatNew: "WhatIsNewObject-Item-6".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                                                    WhatIsNewObject(whatNew: "WhatIsNewObject-Item-7".localizedSwiftUI(CurrentLanguage.shared.currentLanguage)),
                                                    WhatIsNewObject(whatNew: "WhatIsNewObject-Item-8".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))]
    
    var body: some View {
        
        VStack {
        
            Form {
                
                Section {
                    
                    List($whatIsNewArray) { $currentNew in
                        
                        HStack {
                            
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.blue)
                            Text(currentNew.whatNew)
                            
                        }
                        
                    }
                    
                } header: {
                    Text("Version-title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) + " 1.0.1")
                } footer: {
                    Text("Main-Text-Footer.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage) + " 🤍")
                }
                
            }
            
        }
        
        .navigationTitle("What-New.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
        
    }
}

struct WhatIsNewObject: Identifiable {
    let id = UUID()
    let whatNew: String
}

#Preview {
    WhatIsNew()
}
