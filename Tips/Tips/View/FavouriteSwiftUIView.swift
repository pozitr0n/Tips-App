//
//  FavouriteSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024.
//

import SwiftUI

struct FavouriteSwiftUIView: View {
    
    let courseArray: [CourseObject] = [
        CourseObject(courseName:
                        "Recepit 1", aboutCourse: "Recepit information"),
        CourseObject(courseName:
                        "Recepit 2", aboutCourse: "Recepit information"),
        CourseObject(courseName:
                        "Recepit 3", aboutCourse: "Recepit information"),
        CourseObject(courseName:
                        "Recepit 4", aboutCourse: "Recepit information"),
        CourseObject(courseName:
                        "Recepit 5", aboutCourse: "Recepit information"),
        CourseObject(courseName:
                        "Recepit 6", aboutCourse: "Recepit information")
    ]
    
    var body: some View {
        
        NavigationView {
            
            // create List + array
            List(courseArray) { array in
                
                NavigationLink(destination: DetailScreen(courseItem: array)) {
                    
                    VStack {
                        Text(array.courseName)
                            .padding(.trailing)
                    }
                    
                }
                
            }
            .navigationTitle("Favourite")
            
        }
        
    }

}

struct DetailScreen: View {
    
    let courseItem: CourseObject
    
    var body: some View {
     
        VStack(alignment: .leading) {
            
            HStack {
                Text(courseItem.courseName)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            Text(courseItem.aboutCourse)
                .padding(.top)
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(courseItem.courseName), displayMode: .inline)
        
    }
    
}

struct CourseObject: Identifiable {
    let id = UUID()
    let courseName: String
    let aboutCourse: String
}

#Preview {
    FavouriteSwiftUIView()
}
