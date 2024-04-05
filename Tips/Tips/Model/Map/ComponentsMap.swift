//
//  ComponentsMap.swift
//  Tips
//
//  Created by Raman Kozar on 02/04/2024.
//

import Foundation
import SwiftUI

//  A structure containing all path information
//  Parameters:
//      - name: province name specified inside the <path> element
//      - id: identifier of the province that contains the identifier in the <path> element
//      - title: the name of the country from SVG
//      - path: an array of ExecutePathCommand's that is parsed from ParserForWorldLowMap
//
@available(iOS 17.0, *)
public struct PathOfTheInformation: Identifiable, Sendable {
    
    public var id: String               = ""
    public var name: String             = ""
    public var title: String            = ""
    public var boundingFrame: CGRect?   = nil
    public var boundariesOfSVG: CGRect? = nil
    
    var mainPath = [ExecutePathCommand]()

    public init(name: String, id: String, title: String, mainPath: [ExecutePathCommand], boundingFrame: CGRect) {
        self.name           = name
        self.id             = id
        self.title          = title
        self.mainPath       = mainPath
        self.boundingFrame  = boundingFrame
    }
    
    public init(name: String, id: String, title: String, mainPath: [ExecutePathCommand]) {
        self.name       = name
        self.id         = id
        self.title      = title
        self.mainPath   = mainPath
    }
    
    public init() { }
    
}

//  Running command for SVG components
//
@available(iOS 17.0, *)
func runCommandForSVGComponents(dataOfTheSVG: PathOfTheInformation, rect: CGRect) -> Path {
    
    var pathSVG = Path()
    
    var lastPoint: CGPoint = .zero
    var firstControlPoint: CGPoint? = nil
    var secondControlPoint: CGPoint? = nil
    
    for executePathCommand in dataOfTheSVG.mainPath {
        
        if executePathCommand.command == "M" {
            pathSVG.move(to: executePathCommand.coordinateXY)
            lastPoint = executePathCommand.coordinateXY
        }
        
        if executePathCommand.command == "m" {
            
            let point = CGPoint(x: executePathCommand.coordinateXY.x + lastPoint.x,
                                y: executePathCommand.coordinateXY.y + lastPoint.y)
            
            pathSVG.move(to: point)
            lastPoint = point
            
        }
        
        if executePathCommand.command == "L" {
            pathSVG.addLine(to: executePathCommand.coordinateXY)
            lastPoint = executePathCommand.coordinateXY
        }
        
        if executePathCommand.command == "l" {
            
            let point = CGPoint(x: executePathCommand.coordinateXY.x + lastPoint.x,
                                y: executePathCommand.coordinateXY.y + lastPoint.y)
            
            pathSVG.addLine(to: point)
            lastPoint = point
            
        }
        
        if executePathCommand.command == "h" {
            
            let point = CGPoint(x: executePathCommand.coordinateXY.x + lastPoint.x,
                                y: lastPoint.y)
            
            pathSVG.addLine(to: point)
            lastPoint = point
            
        }
        
        if executePathCommand.command == "H" {
            
            let point = CGPoint(x: executePathCommand.coordinateXY.x,
                                y: lastPoint.y)
            pathSVG.addLine(to: point)
            
            lastPoint = point
            
        }
        
        if executePathCommand.command == "v" {
            
            let point = CGPoint(x: lastPoint.x,
                                y: executePathCommand.coordinateXY.y + lastPoint.y)
            
            pathSVG.addLine(to: point)
            lastPoint = point
            
        }
        
        if executePathCommand.command == "V" {
            
            let point = CGPoint(x: lastPoint.x,
                                y: executePathCommand.coordinateXY.y)
            
            pathSVG.addLine(to: point)
            lastPoint = point
            
        }
        
        if executePathCommand.command == "z" || executePathCommand.command == "Z" {
            pathSVG.closeSubpath()
        }
        
        if executePathCommand.command == "C" {
            
            guard let point1 = firstControlPoint else {
                firstControlPoint = executePathCommand.coordinateXY
                continue
            }
            
            guard let point2 = secondControlPoint else {
                secondControlPoint = executePathCommand.coordinateXY
                continue
            }
            
            pathSVG.addCurve(to: executePathCommand.coordinateXY, control1: point1, control2: point2)
            firstControlPoint = nil
            secondControlPoint = nil
            
            lastPoint = executePathCommand.coordinateXY
            
        }
        
        if executePathCommand.command == "c" {
            
            guard let c1 = firstControlPoint else {
                firstControlPoint = executePathCommand.coordinateXY
                continue
            }
            
            guard let c2 = secondControlPoint else {
                secondControlPoint = executePathCommand.coordinateXY
                continue
            }
            
            pathSVG.addCurve(to: CGPoint(x: executePathCommand.coordinateXY.x + lastPoint.x,
                                         y: executePathCommand.coordinateXY.y + lastPoint.y),
                             control1: CGPoint(x: c1.x + lastPoint.x, y: c1.y + lastPoint.y),
                             control2: CGPoint(x: c2.x + lastPoint.x, y: c2.y + lastPoint.y))
            
            firstControlPoint = nil
            secondControlPoint = nil
            
            lastPoint = CGPoint(x: executePathCommand.coordinateXY.x + lastPoint.x,
                                y: executePathCommand.coordinateXY.y + lastPoint.y)
            
        }
        
    }
    
    if let boundariesOfSVG = dataOfTheSVG.boundariesOfSVG {
        
        let scaleHorizontal = rect.size.width / (boundariesOfSVG.width)
        let scaleVertical   = rect.size.height / (boundariesOfSVG.height)
        let scale           = min(scaleHorizontal, scaleVertical)
        
        var scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        scaleTransform = scaleTransform.translatedBy(x: -boundariesOfSVG.origin.x,
                                                     y: -boundariesOfSVG.origin.y)
        
        return pathSVG.applying(scaleTransform)
        
    }
    
    return pathSVG
    
}

@available(iOS 17.0, *)
extension PathOfTheInformation: Equatable {
    
    public static func == (lhs: PathOfTheInformation, rhs: PathOfTheInformation) -> Bool {
        lhs.id == rhs.id
    }
    
}
