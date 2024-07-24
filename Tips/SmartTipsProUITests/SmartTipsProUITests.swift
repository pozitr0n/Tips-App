//
//  SmartTipsProUITests.swift
//  SmartTipsProUITests
//
//  Created by Raman Kozar on 24/07/2024.
//

import XCTest

final class SmartTipsProUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        let pasekKartTabBar = app.tabBars["Pasek kart"]
        let ulubioneButton = pasekKartTabBar.buttons["Ulubione"]
        ulubioneButton.tap()
        
        let przewodnikButton = pasekKartTabBar.buttons["Przewodnik"]
        przewodnikButton.tap()
        pasekKartTabBar.buttons["Ustawienia"].tap()
        przewodnikButton.tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.children(matching: .other).element.children(matching: .other).element.tap()
        app.collectionViews.containing(.other, identifier:"Pasek przewijania pionowego, 3 strony").element.swipeUp()
        ulubioneButton.tap()
        app.collectionViews["Pasek boczny"]/*@START_MENU_TOKEN@*/.staticTexts["24.07.2024 o 19:56:30"]/*[[".cells",".buttons[\"24.07.2024 o 19:56:30\"].staticTexts[\"24.07.2024 o 19:56:30\"]",".staticTexts[\"24.07.2024 o 19:56:30\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["24.07.2024 o 19:56:30"].buttons["Ulubione"].tap()
        pasekKartTabBar.buttons["Kalkulator"].tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.toolbars["Toolbar"]/*[[".toolbars[\"Pasek narzędzi\"]",".toolbars[\"Toolbar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Gotowe"].tap()
        
        let dodajImage = app.buttons["Dodaj"].children(matching: .image).matching(identifier: "Dodaj").element(boundBy: 0)
        dodajImage.tap()
        dodajImage.tap()
        dodajImage.tap()
        dodajImage.tap()
        scrollViewsQuery.otherElements.buttons["15%"].tap()
        app.navigationBars["Kalkulator"].buttons["Udostępnij"].tap()
        
        let uchwytArkuszaButton = app.buttons["Uchwyt arkusza"]
        uchwytArkuszaButton.swipeDown()
        uchwytArkuszaButton.swipeDown()
        window.children(matching: .other).element(boundBy: 0)/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"zamknij okno wyskakujące\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        uchwytArkuszaButton.swipeDown()
        
    }

    func testLaunchPerformance() throws {
        
        if #available(iOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                let app = XCUIApplication()
                app.launch()
            }
        }
        
    }
    
}
