//
//  WhatIsNew.swift
//  Tips
//
//  Created by Raman Kozar on 10/04/2024.
//

import SwiftUI

struct WhatIsNew: View {
    
    // Add all the new information about the logic of the application
    //
    @State var whatIsNewArray: [WhatIsNewObject] = [WhatIsNewObject(whatNew: "New 1"),
                                                    WhatIsNewObject(whatNew: "New 2"),
                                                    WhatIsNewObject(whatNew: "New 3"),
                                                    WhatIsNewObject(whatNew: "New 4"),
                                                    WhatIsNewObject(whatNew: "New 5"),
                                                    WhatIsNewObject(whatNew: "New 6"),
                                                    WhatIsNewObject(whatNew: "New 7")]
    
    var body: some View {
        
        Form {
            
            Section("Version: 1.0") {
                
                List($whatIsNewArray) { $currentNew in
                    
                    HStack {
                        
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.blue)
                        Text(currentNew.whatNew)
                        
                    }
                    
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
