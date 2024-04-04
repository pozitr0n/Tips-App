//
//  ParseringMap.swift
//  Tips
//
//  Created by Raman Kozar on 02/04/2024.
//

import Foundation
import SwiftUI

// Filename needs for parsing SVG
// Can be written with or without .svg extension
//
@available(iOS 17.0, *)
final class ParserForWorldLowMap: NSObject, XMLParserDelegate {
    
    var minimunOX = Double.greatestFiniteMagnitude
    var maximumOX = -Double.greatestFiniteMagnitude
    var minimunOY = Double.greatestFiniteMagnitude
    var maximumOY = -Double.greatestFiniteMagnitude
    
    var width: CGFloat = .zero
    var height: CGFloat = .zero
    var bounds: CGRect = .zero

    var size: CGSize
    var arrayPathInformation: [PathOfTheInformation] = []
    var quantityScale = 1.0
    
    init(nameOfSVG: String, size: CGSize) {
        
        self.size = size
        super.init()
        self.doParsingOfSVG(nameOfTheFile: nameOfSVG)
        
    }
    
    // Parsing the SVG file
    // Contains checking: if argument has .svg extension inside the name, if not - adding it
    //
    func doParsingOfSVG(nameOfTheFile: String) {
        
        var pathToTheSVGFile: String?
        
        if nameOfTheFile.contains(".svg") {
            pathToTheSVGFile = Bundle.main.path(forResource: nameOfTheFile, ofType: nil)
        } else {
            pathToTheSVGFile = Bundle.main.path(forResource: nameOfTheFile, ofType: "svg")
        }
        
        guard let pathToTheSVGFile = pathToTheSVGFile else {
            print("Interactive ParserForWorldLowMap Error: File Not Found!")
            return
        }
        
        // configuration of the parser
        if let parser = XMLParser(contentsOf: URL(fileURLWithPath: pathToTheSVGFile)) {
            parser.delegate = self
            parser.parse()
        }
        
    }
    
    // Calculating boundaries
    //
    public func calculateBoundaries() {
        
        var maximumOX = -CGFloat.greatestFiniteMagnitude
        var maximumOY = -CGFloat.greatestFiniteMagnitude
        
        bounds.origin.x = CGFloat.greatestFiniteMagnitude
        bounds.origin.y = CGFloat.greatestFiniteMagnitude

        for currIndex in 0..<arrayPathInformation.count {
            
            var path = arrayPathInformation[currIndex]
            
            let currentCxecuteCommand = runCommandForSVGComponents(dataOfTheSVG: path,
                                                                   rect: CGRect(x: 0, y: 0, width: size.width, height: size.height)).boundingRect;
            
            if currentCxecuteCommand.origin.x < bounds.origin.x {
                bounds.origin.x = currentCxecuteCommand.origin.x
            }
            
            if currentCxecuteCommand.origin.y < bounds.origin.y {
                bounds.origin.y = currentCxecuteCommand.origin.y
            }
            
            if (currentCxecuteCommand.origin.x + currentCxecuteCommand.size.width > maximumOX) {
                maximumOX = currentCxecuteCommand.origin.x + currentCxecuteCommand.size.width
            }
            
            if (currentCxecuteCommand.origin.y + currentCxecuteCommand.size.height > maximumOY) {
                maximumOY = currentCxecuteCommand.origin.y + currentCxecuteCommand.size.height
            }
            
            path.boundingFrame = currentCxecuteCommand
            arrayPathInformation[currIndex] = path
            
        }
        
        bounds.size.width = maximumOX - bounds.origin.x;
        bounds.size.height = maximumOY - bounds.origin.y;
        
        for currIndex in 0..<arrayPathInformation.count {
            
            var path = arrayPathInformation[currIndex]
            
            path.boundariesOfSVG = bounds
            arrayPathInformation[currIndex] = path
            
        }
        
    }
    
    // parserDidEndDocument method
    //
    public func parserDidEndDocument(_ parser: XMLParser) {
        self.calculateBoundaries()
    }
    
    //  Delegate of the XMLParser
    //
    //  Additional: 'd' attribute in paths, known as the `geometry` attribute, contains all the information (coordinates, commands)
    //  about path that are needed for drawing operations
    //
    //  Algorithm:
    //
    //  - First Loop: initialize first command (mostly M or m). Collect all "coordinates" related to that command.
    //
    //  - Other Loops: when encountered a letter, scan every coordinate collected from the previous command. Convert them to integers using scanner, then add them as
    //    execution commands to related PathData. Finally, replace previous command with new command. Repeat this process
    //
    public func parser(_ parser: XMLParser,
                       didStartElement elementName: String,
                       namespaceURI: String?,
                       qualifiedName qName: String?,
                       attributes attributeDictionary: [String : String] = [:]) {
        
        //  All the .svg based maps differentiate provinces and districts by seperating them in <path> element. That's why we're looping through paths
        if elementName == "path" {
            
            var pathInfo = PathOfTheInformation(name: attributeDictionary["name"] ?? attributeDictionary["id"] ?? "undefined",
                                                id: attributeDictionary["id"] ?? (attributeDictionary["name"] ?? UUID().uuidString), 
                                                title: attributeDictionary["title"] ?? attributeDictionary["title"] ?? "undefined",
                                                mainPath: [])
            
            // Empty char
            var currentOperation: Character = "\0"
            var currentCoordinates = ""
            var isTheFirstLoop = true
            
            for char in attributeDictionary["d"]! {
                
                if (char.isLetter) {
                    
                    // Initialization of the first operation (command)
                    if isTheFirstLoop {
                        
                        currentOperation = char
                        isTheFirstLoop = false
                        
                    } else {
                        
                        // Sometimes the scanner cannot detect empty spaces
                        let currentScan = Scanner(string: currentCoordinates.replacingOccurrences(of: " ", with: ","))
                        
                        var coordinateX = 0.0
                        var coordinateY = 0.0
                        var previousValueScanned = currentOperation.lowercased() == "h" || currentOperation.lowercased() == "v"
                        
                        currentScan.charactersToBeSkipped = ["\n", ","]
                        
                        // Scaning for the coordinates
                        while(!currentScan.isAtEnd) {
                            
                            let currentValue = currentScan.scanDouble()
                            
                            if let currentValue = currentValue {
                                if previousValueScanned {
                                    if (currentOperation.lowercased() == "h") {
                                        
                                        coordinateX = currentValue * quantityScale
                                        
                                        minimunOX = min(coordinateX, minimunOX)
                                        maximumOX = max(coordinateX, maximumOX)
                                        
                                        pathInfo.mainPath.append(ExecutePathCommand(coordinateXY: CGPoint(x: coordinateX, y: 0.0),
                                                                                  command: String(currentOperation)))
                                        
                                    } else {
                                        
                                        minimunOY = min(currentValue, minimunOY)
                                        maximumOY = max(currentValue, maximumOY)
                                        
                                        coordinateY = currentValue * quantityScale
                                        
                                        pathInfo.mainPath.append(ExecutePathCommand(coordinateXY: CGPoint(x: coordinateX, y: coordinateY),
                                                                                  command: String(currentOperation)))
                                    }
                                } else {
                                    
                                    coordinateX = currentValue * quantityScale
                                    
                                    minimunOX = min(coordinateX, minimunOX)
                                    maximumOX = max(coordinateX, maximumOX)
                                    
                                }
                            } else {
                                
                                print("Interactive ParserForWorldLowMap Error: Found Invalid Coordinates Inside SVG-file")
                                print("Scanned string: \(currentScan.string)")
                                
                                break
                                
                            }
                            
                            previousValueScanned.toggle()
                            
                        }
                        
                        currentCoordinates = ""
                        currentOperation = char
                        
                    }
                    
                    if (char == "z" || char == "Z") {
                        
                        // .zero stands as a placeholder.
                        pathInfo.mainPath.append(ExecutePathCommand(coordinateXY: .zero,
                                                                  command: String(char)))
                        
                    }
                    continue
                }
                
                currentCoordinates.append(char)
                
            }
            
            arrayPathInformation.append(pathInfo)
            
        }
        
    }
    
}

public struct ExecutePathCommand: CustomStringConvertible, Identifiable, Sendable {
    
    var coordinateXY: CGPoint
    var command: String
    
    public var id = UUID()
    public var description: String {
        return "ExecutePathCommand(coordinate: \(coordinateXY), command: \(command))\n"
    }
    
    public init(coordinateXY: CGPoint, command: String) {
        self.coordinateXY = coordinateXY
        self.command = command
    }
    
}
