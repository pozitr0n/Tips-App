//
//  FavouriteSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024.
//

import SwiftUI

struct FavouriteSwiftUIView: View {
    
    let testArray: [TestObject] = [
        TestObject(name: "Recepit 1", about: "Recepit information"),
        TestObject(name: "Recepit 2", about: "Recepit information"),
        TestObject(name: "Recepit 3", about: "Recepit information"),
        TestObject(name: "Recepit 4", about: "Recepit information"),
        TestObject(name: "Recepit 5", about: "Recepit information"),
        TestObject(name: "Recepit 6", about: "Recepit information")
    ]
    
    var body: some View {
        
        NavigationView {
            
            // create List + array
            List(testArray) { array in
                
                NavigationLink(destination: DetailScreen(testItem: array)) {
                    
                    VStack {
                        Text(array.name)
                            .padding(.trailing)
                    }
                    
                }
                
            }
            .navigationTitle("Favourite")
            
        }
        
    }

}

struct DetailScreen: View {
    
    let testItem: TestObject
    
    var body: some View {
     
        VStack(alignment: .leading) {
            
            HStack {
                Text(testItem.name)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            Text(testItem.name)
                .padding(.top)
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(testItem.name), displayMode: .inline)
        
    }
    
}

struct TestObject: Identifiable {
    let id = UUID()
    let name: String
    let about: String
}

#Preview {
    FavouriteSwiftUIView()
}
