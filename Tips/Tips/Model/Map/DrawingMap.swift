//
//  DrawingMap.swift
//  Tips
//
//  Created by Raman Kozar on 02/04/2024.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
public struct MapInteractive<Content>: View where Content: View {
    
    //  State variable of pathInformation
    @State private var pathInformation = [PathOfTheInformation]()
    
    //  SVG name that can be written with/without file extension
    let nameOtTheSVG: String
    
    //  Closure (need for customizing the map)
    var content: ((_ pathData: PathOfTheInformation) -> Content)
    
    public init(nameOtTheSVG: String, @ViewBuilder content: @escaping (_ pathData: PathOfTheInformation) -> Content) {
        self.nameOtTheSVG = nameOtTheSVG
        self.content = content
    }
 
    public var body: some View {
        
        GeometryReader { geoData in
            ZStack {

                //  the data has not yet been initialized. That is, we are waiting for .onAppear to be triggered
                if !pathInformation.isEmpty {
                    ForEach(pathInformation) { pathInformation in
                        content(pathInformation)
                    }
                    
                }
                
            }
            .onAppear {
                
                // scaling paths to fit screen size
                let parser = ParserForWorldLowMap(nameOfSVG: nameOtTheSVG, size: geoData.size)
                pathInformation = parser.arrayPathInformation
                
            }
        }
        
    }
    
}

//  Default attributes for a map
//
@available(iOS 17.0, *)
public struct DefaultAttributes {
   
    public var runningWidth: Double
    public var runningColor: Color
    public var background: Color
    
    public init(runningWidth: Double = 1.2, runningColor: Color = .black, background: Color = Color(.sRGB, white: 0.5, opacity: 1)) {
        
        self.runningWidth = runningWidth
        self.runningColor = runningColor
        self.background = background
        
    }
    
}

//  A shape that brings together the entire map in combination with other interactive objects
//  Parameters:
//  pathInformation - this is a structure that contains everything related to the path (id, name, path, boundingRect and svgBounds)
//
@available(iOS 17.0, *)
public struct ShapeInteractive: Shape {
    
    let pathInformation: PathOfTheInformation
    
    public func path(in rect: CGRect) -> Path {
        let currPath = runCommandForSVGComponents(dataOfTheSVG: pathInformation, rect: rect)
        return currPath
    }
    
    public init (_ pathInformation: PathOfTheInformation) {
        self.pathInformation = pathInformation
    }
    
}

@available(iOS 17.0, *)
extension ShapeInteractive {
    
    //  using default DefaultAttributes for map-coloring
    public func initWithAttributes() -> some View {
        
        let attributes = DefaultAttributes()
        return self
            .stroke(attributes.runningColor, lineWidth: attributes.runningWidth)
            .background(self.fill(attributes.background))
        
    }
    
    public func initWithAttributes(_ attributes : DefaultAttributes) -> some View {
        self
            .stroke(attributes.runningColor, lineWidth: attributes.runningWidth)
            .background(self.fill(attributes.background))
    }
    
}
