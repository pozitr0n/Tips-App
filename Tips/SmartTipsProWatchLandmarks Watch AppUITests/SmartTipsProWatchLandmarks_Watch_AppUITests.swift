//
//  SmartTipsProWatchLandmarks_Watch_AppUITests.swift
//  SmartTipsProWatchLandmarks Watch AppUITests
//
//  Created by Raman Kozar on 29/07/2024.
//

import XCTest

final class SmartTipsProWatchLandmarks_Watch_AppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
    
        let app = XCUIApplication()
        app.launch()
        
        sleep(5)
        
        let scrollViewsQuery = app.scrollViews
        let iconBillApplewatchElement = scrollViewsQuery.otherElements.containing(.image, identifier:"icon-bill-applewatch").element
        iconBillApplewatchElement.swipeUp()
        
        let elementsQuery = scrollViewsQuery.otherElements
        let addButton = elementsQuery.buttons["Add"]
        addButton.tap()
        addButton.tap()
        addButton.tap()
        addButton.tap()
        elementsQuery.sliders["0%"].tap()
        
        let quickTipsStaticText = elementsQuery.staticTexts["Quick Tips"]
        quickTipsStaticText.swipeUp()
        quickTipsStaticText.swipeDown()
        elementsQuery.buttons["0.00"].tap()
        
        _ = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element

        app.buttons["Done"].tap()
        iconBillApplewatchElement.swipeUp()
        elementsQuery/*@START_MENU_TOKEN@*/.images["iphone.circle"]/*[[".buttons[\"Move, arrow.forward, iphone.circle\"].images[\"iphone.circle\"]",".images[\"iphone.circle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.buttons["Total, 0.00"].swipeDown()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
}
