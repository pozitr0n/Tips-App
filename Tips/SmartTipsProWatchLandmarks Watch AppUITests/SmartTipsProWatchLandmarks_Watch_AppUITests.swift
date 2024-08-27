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
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["0.00"].tap()
        app.buttons["5"].tap()
        
        let button = app.buttons["0"]
        button.tap()
        button.tap()
        button.tap()
        app.buttons["Done"].tap()
        scrollViewsQuery.otherElements.containing(.image, identifier:"icon-bill-applewatch").element.swipeUp()
        elementsQuery.otherElements["Select Currency"].tap()
        
        let peopleStaticText = elementsQuery.staticTexts["People"]
        peopleStaticText.tap()
        peopleStaticText.swipeUp()
        
        let addButton = elementsQuery.buttons["Add"]
        addButton.tap()
        addButton.tap()
        addButton.tap()
        addButton.tap()
        addButton.tap()
        elementsQuery.staticTexts["Quick Tips"].swipeUp()
        elementsQuery.sliders["0%"].tap()
        elementsQuery.sliders["1%"].tap()
        elementsQuery.sliders["2%"].tap()
        elementsQuery.sliders["3%"].tap()
        elementsQuery.sliders["4%"].tap()
        
        let staticText = elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["750.00"]/*[[".buttons[\"Tip, 750.00\"].staticTexts[\"750.00\"]",".staticTexts[\"750.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText.tap()
        staticText.swipeUp()
        elementsQuery.buttons["Move, arrow.forward, iphone.circle"].tap()
        
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
