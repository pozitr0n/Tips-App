//
//  TipGuideSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024.
//

import SwiftUI

struct TipGuideSwiftUIView: View {
    
    let testArray1: [TestObject1] = [
        TestObject1(name: "Recepit 1", about: "Recepit information"),
        TestObject1(name: "Recepit 2", about: "Recepit information"),
        TestObject1(name: "Recepit 3", about: "Recepit information"),
        TestObject1(name: "Recepit 4", about: "Recepit information"),
        TestObject1(name: "Recepit 5", about: "Recepit information"),
        TestObject1(name: "Recepit 6", about: "Recepit information")
    ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Bar")) {
                    // create List + array
                    List(testArray1) { array in
                        
                        NavigationLink(destination: DetailScreen1(testItem1: array)) {
                            
                            VStack {
                                Text(array.name)
                                    .padding(.trailing)
                            }
                            
                        }
                        
                    }
                }
                
                Section(header: Text("Hotel")) {
                    // create List + array
                    List(testArray1) { array in
                        
                        NavigationLink(destination: DetailScreen1(testItem1: array)) {
                            
                            VStack {
                                Text(array.name)
                                    .padding(.trailing)
                            }
                            
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Tip-Guide.title".localizedSwiftUI(CurrentLanguage.shared.currentLanguage))
            
        }
        
    }
}

struct DetailScreen1: View {
    
    let testItem1: TestObject1
    
    var body: some View {
     
        VStack(alignment: .leading) {
            
            HStack {
                Text(testItem1.name)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            Text(testItem1.about)
                .padding(.top)
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(testItem1.name), displayMode: .inline)
        
    }
    
}

struct TestObject1: Identifiable {
    let id = UUID()
    let name: String
    let about: String
}


#Preview {
    TipGuideSwiftUIView()
}
