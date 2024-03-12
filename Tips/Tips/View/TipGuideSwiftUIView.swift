//
//  TipGuideSwiftUIView.swift
//  Tips
//
//  Created by Raman Kozar on 12/03/2024.
//

import SwiftUI

struct TipGuideSwiftUIView: View {
    
    let courseArray1: [CourseObject1] = [
        CourseObject1(courseName:
                        "Recepit 1", aboutCourse: "Recepit information"),
        CourseObject1(courseName:
                        "Recepit 2", aboutCourse: "Recepit information"),
        CourseObject1(courseName:
                        "Recepit 3", aboutCourse: "Recepit information"),
        CourseObject1(courseName:
                        "Recepit 4", aboutCourse: "Recepit information"),
        CourseObject1(courseName:
                        "Recepit 5", aboutCourse: "Recepit information"),
        CourseObject1(courseName:
                        "Recepit 6", aboutCourse: "Recepit information")
    ]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("Bar")) {
                    // create List + array
                    List(courseArray1) { array in
                        
                        NavigationLink(destination: DetailScreen1(courseItem1: array)) {
                            
                            VStack {
                                Text(array.courseName)
                                    .padding(.trailing)
                            }
                            
                        }
                        
                    }
                }
                
                Section(header: Text("Hotel")) {
                    // create List + array
                    List(courseArray1) { array in
                        
                        NavigationLink(destination: DetailScreen1(courseItem1: array)) {
                            
                            VStack {
                                Text(array.courseName)
                                    .padding(.trailing)
                            }
                            
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Tip Guide")
            
        }
        
    }
}

struct DetailScreen1: View {
    
    let courseItem1: CourseObject1
    
    var body: some View {
     
        VStack(alignment: .leading) {
            
            HStack {
                Text(courseItem1.courseName)
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            
            Text(courseItem1.aboutCourse)
                .padding(.top)
            
            Spacer()
            
        }
        .padding()
        .navigationBarTitle(Text(courseItem1.courseName), displayMode: .inline)
        
    }
    
}

struct CourseObject1: Identifiable {
    let id = UUID()
    let courseName: String
    let aboutCourse: String
}


#Preview {
    TipGuideSwiftUIView()
}
