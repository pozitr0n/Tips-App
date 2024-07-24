//
//  SmartTipsProTests.swift
//  SmartTipsProTests
//
//  Created by Raman Kozar on 24/07/2024.
//

import XCTest
@testable import SmartTipsPro

class MockTipCalculator: TipsCalculations {
    
    var calculateTipCalled = false
    var calculateBillCalled = false
    var calculateTotal = false
    var calculateBillPerPerson = false
    var calculateTipPerPerson = false
    var calculateTotalPerPerson = false
    
    override func calculateTipSummary(startSum: Double, percent: Double) -> Double {
        calculateTipCalled = true
        return super.calculateTipSummary(startSum: startSum, percent: percent)
    }
    
    override func calculateBillSummary(startSum: Double) -> Double {
        calculateBillCalled = true
        return super.calculateBillSummary(startSum: startSum)
    }
    
    override func calculateTotalSummary(startSum: Double, percent: Double) -> Double {
        calculateTotal = true
        return super.calculateTotalSummary(startSum: startSum, percent: percent)
    }
    
    override func calculateBillPerPerson(startSum: Double, numberOfPersons: Int) -> Double {
        calculateBillPerPerson = true
        return super.calculateBillPerPerson(startSum: startSum, numberOfPersons: numberOfPersons)
    }
    
    override func calculateTipPerPerson(startSum: Double, percent: Double, numberOfPersons: Int) -> Double {
        calculateTipPerPerson = true
        return super.calculateTipPerPerson(startSum: startSum, percent: percent, numberOfPersons: numberOfPersons)
    }
    
    override func calculateTotalPerPerson(startSum: Double, percent: Double, numberOfPersons: Int) -> Double {
        calculateTotalPerPerson = true
        return super.calculateTotalPerPerson(startSum: startSum, percent: percent, numberOfPersons: numberOfPersons)
    }
    
}

final class SmartTipsProTests: XCTestCase {

    var calculator: TipsCalculations!
    var mockCalculator: MockTipCalculator!
    
    override func setUpWithError() throws {
        calculator = TipsCalculations()
        mockCalculator = MockTipCalculator()
    }

    override func tearDownWithError() throws {
        calculator = nil
        mockCalculator = nil
    }

    func testExample() throws {
        
        let expected = 114.9
        
        let resultTip = calculator.calculateTipSummary(startSum: 100.0, percent: 15.0)
        XCTAssertEqual(resultTip, 15, "Expected 15.0 as the tip for 100.0 amount with 15% tip")
        
        let resultBill = calculator.calculateBillSummary(startSum: 100.0)
        XCTAssertEqual(resultBill, 100.0, "Comparing 100.0 with 100.0")
        
        let resultTotal = calculator.calculateTotalSummary(startSum: 100.0, percent: 15.0)
        XCTAssertEqual(resultTotal, expected, accuracy: 0.1, "The result should be equal to 114.9 with an allowable error of 0.1")
        
        let resultBillPerPerson = calculator.calculateBillPerPerson(startSum: 100.0, numberOfPersons: 2)
        XCTAssertEqual(resultBillPerPerson, 50.0, "Comparing 50.0 with 50.0")
        
        let resultTipPerPerson = calculator.calculateTipPerPerson(startSum: 100.0, percent: 15.0, numberOfPersons: 2)
        XCTAssertEqual(resultTipPerPerson, 7.5, "Comparing 50.0 with 50.0")
        
        let resultTotalPerPerson = calculator.calculateTotalPerPerson(startSum: 100.0, percent: 15.0, numberOfPersons: 2)
        XCTAssertEqual(resultTotalPerPerson, 57.5, "Comparing 50.0 with 50.0")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMockCalculateTipCalled() throws {
       
        _ = mockCalculator.calculateTipSummary(startSum: 100.0, percent: 15.0)
        XCTAssertTrue(mockCalculator.calculateTipCalled, "Expected calculateTip to be called in MockTipCalculator")
        
        _ = mockCalculator.calculateBillSummary(startSum: 100.0)
        XCTAssertTrue(mockCalculator.calculateBillCalled, "Expected calculateBill to be called in MockTipCalculator")
        
        _ = mockCalculator.calculateTotalSummary(startSum: 100.0, percent: 15.0)
        XCTAssertTrue(mockCalculator.calculateTotal, "Expected calculateTotal to be called in MockTipCalculator")
        
        _ = mockCalculator.calculateBillPerPerson(startSum: 100.0, numberOfPersons: 2)
        XCTAssertTrue(mockCalculator.calculateBillPerPerson, "Expected calculateBillPerPerson to be called in MockTipCalculator")
        
        _ = mockCalculator.calculateTipPerPerson(startSum: 100.0, percent: 15.0, numberOfPersons: 2)
        XCTAssertTrue(mockCalculator.calculateTipPerPerson, "Expected calculateTipPerPerson to be called in MockTipCalculator")
        
        _ = mockCalculator.calculateTotalPerPerson(startSum: 100.0, percent: 15.0, numberOfPersons: 2)
        XCTAssertTrue(mockCalculator.calculateTotalPerPerson, "Expected calculateTotalPerPerson to be called in MockTipCalculator")
        
    }

}
