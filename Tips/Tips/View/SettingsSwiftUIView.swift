//
//  SettingsSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 14/03/2024.
//

import SwiftUI

struct SettingsSwiftUIView: View {
    
    let testArrayTheme: [TestObject2] = [
        TestObject2(name: "App Icon", about: "App Icon"),
        TestObject2(name: "App Tint", about: "App Tint")
    ]
    
    let testArrayGeneral: [TestObject2] = [
        TestObject2(name: "Current format", about: "Current format"),
        TestObject2(name: "Default Percentage", about: "Default Percentage")
    ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Theme")) {
                    // create List + array
                    List(testArrayTheme) { array in
                        
                        NavigationLink(destination: DetailScreen2(testItem2: array)) {
                            
                            VStack {
                                Text(array.name)
                                    .padding(.trailing)
                            }
                            
                        }
                        
                    }
                }
                
                Section(header: Text("General")) {
                    // create List + array
                    List(testArrayGeneral) { array in
                        
                        NavigationLink(destination: DetailScreen2(testItem2: array)) {
                            
                            VStack {
                                Text(array.name)
                                    .padding(.trailing)
                            }
                            
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Settings")
            
        }
        
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

struct TestObject2: Identifiable {
    let id = UUID()
    let name: String
    let about: String
}

#Preview {
    SettingsSwiftUIView()
}
