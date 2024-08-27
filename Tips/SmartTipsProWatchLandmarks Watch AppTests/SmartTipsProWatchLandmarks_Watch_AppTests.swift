//
//  SmartTipsProWatchLandmarks_Watch_AppTests.swift
//  SmartTipsProWatchLandmarks Watch AppTests
//
//  Created by Raman Kozar on 29/07/2024.
//

import XCTest
@testable import SmartTipsProWatchLandmarks_Watch_App

class MockSmartTipsProWatchLandmarks_Watch_App: SmartTipsProWatchModel {
    
    var testUpdateTipsInfo = false
    var testIncrementingAmountOfPeople = false
    var testIncrementingAmountOfPeopleEnabled = false
    var testDecrementingAmountOfPeople = false
    var testDecrementingAmountOfPeopleEnabled = false
    var testTransferDataTo_iPhone = false
    
    override func updateTipsInfo() {
        testUpdateTipsInfo = true
        return super.updateTipsInfo()
    }
    
    override func incrementingAmountOfPeople() {
        testIncrementingAmountOfPeople = true
        return super.incrementingAmountOfPeople()
    }
    
    override func incrementingAmountOfPeopleEnabled() -> Bool {
        testIncrementingAmountOfPeopleEnabled = true
        return super.incrementingAmountOfPeopleEnabled()
    }
    
    override func decrementingAmountOfPeople() {
        testDecrementingAmountOfPeople = true
        return super.decrementingAmountOfPeople()
    }
    
    override func decrementingAmountOfPeopleEnabled() -> Bool {
        testDecrementingAmountOfPeopleEnabled = true
        return super.decrementingAmountOfPeopleEnabled()
    }
    
    override func transferDataTo_iPhone() -> Bool {
        testTransferDataTo_iPhone = true
        return super.transferDataTo_iPhone()
    }
        
}

final class SmartTipsProWatchLandmarks_Watch_AppTests: XCTestCase {

    var watchModel: SmartTipsProWatchModel!
    
    override func setUpWithError() throws {
        watchModel = SmartTipsProWatchModel()
    }

    override func tearDownWithError() throws {
        watchModel = nil
    }

    func testExample() throws {
        
        let emptyValue: () = ()
        
        let resultUpdateTipsInfo: () = watchModel.updateTipsInfo()
        XCTAssertTrue(resultUpdateTipsInfo == emptyValue)
        
        let resultIncrementingAmountOfPeople: () = watchModel.incrementingAmountOfPeople()
        XCTAssertTrue(resultIncrementingAmountOfPeople == emptyValue)
        
        let resultIncrementingAmountOfPeopleEnabled: Bool = watchModel.incrementingAmountOfPeopleEnabled()
        XCTAssertTrue(resultIncrementingAmountOfPeopleEnabled == true)
        
        let resultDecrementingAmountOfPeople: () = watchModel.decrementingAmountOfPeople()
        XCTAssertTrue(resultDecrementingAmountOfPeople == emptyValue)
        
        let resultDecrementingAmountOfPeopleEnabled: Bool = watchModel.decrementingAmountOfPeopleEnabled()
        XCTAssertTrue(resultDecrementingAmountOfPeopleEnabled == false)
        
        let resultTransferDataTo_iPhone: Bool = watchModel.transferDataTo_iPhone()
        XCTAssertTrue(resultTransferDataTo_iPhone == true)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            
            let resultTransferDataTo_iPhone: Bool = watchModel.transferDataTo_iPhone()
            XCTAssertEqual(resultTransferDataTo_iPhone, true)
            
        }
    }

}
