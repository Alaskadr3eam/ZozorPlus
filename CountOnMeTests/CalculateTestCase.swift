//
//  CalculateTestCase.swift
//  CountOnMeTests
//
//  Created by Clément Martin on 19/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculateTestCase: XCTestCase {

    var calculates: Calculate!

    override func setUp() {
        super.setUp()
        calculates = Calculate()
    }

    func operation(_ one: Int, _ sign: Operator, _ two: Int) {

        calculates.addNewNumber(one)
        calculates.addOperation(sign)
        calculates.addNewNumber(two)
        calculates.calculateTotal()

    }
    
    func operationPlusMemory(_ one:Int,_ sign: Operator,_ two: Int) {
        calculates.addNewNumberEveryWhere(one)
        calculates.addOperation(sign)
        calculates.addNewNumberEveryWhere(one)
        calculates.calculateTotal()
    }

    func testIsExpressionCorrect() {
        calculates.addNewNumber(1)
        calculates.addOperation(.soustraction)
        calculates.addNewNumber(1)

        XCTAssertTrue(calculates.isExpressionCorrect)
    }
    
    func testIsExpressionCorrectFalse() {
        calculates.addNewNumber(1)
        calculates.addOperation(.soustraction)
        calculates.addOperation(.soustraction)

        XCTAssertFalse(calculates.isExpressionCorrect)
    }

    func testAddOperator() {

        calculates.addOperation(.soustraction)

        XCTAssertFalse(calculates.canAddOperator)

    }

    func testAddNewNumber() {

        calculates.addNewNumber(1)

       XCTAssert(calculates.stringNumbers[0] == "1")

    }

    func testGivenOperation_WhenSixAndFiveAreAdditionned_ThenResultShouldBeEleven() {

        operation(5, .addition, 6)

        XCTAssert(calculates.total == 11)
    }

    func testGivenOperation_WhenSixAndFiveAreSubtracted_ThenResultShouldBeMinusOne() {

        operation(5, .soustraction, 6)

        XCTAssert(calculates.total == -1)
    }

    func testGivenOperation_WhenSixAndFiveAreDivided_ThenResultShouldBeZero() {

        operation(5, .division, 2)

        XCTAssertFalse(calculates.total == 0)
        XCTAssertTrue(calculates.total == 2.5)
    }

    func testtestGivenOperation_WhenSixAndFiveAreMultiplied_ThenResultShouldBeThirty() {

        operation(5, .multiplication, 6)

        //XCTAssert(calculates.total == 30)
        XCTAssertTrue(calculates.total == 30)
        XCTAssertFalse(calculates.total == 20)
    }

    func testClear() {
        operation(5, .soustraction, 6)
        calculates.total = -1

        calculates.clear()

        XCTAssertTrue(calculates.stringNumbers == [String]())
        XCTAssertTrue(calculates.operators == [.addition])
        XCTAssertTrue(calculates.total == 0)
    }

    func testAddMem() {
        calculates.addMem("100")

        XCTAssertTrue(calculates.memoryCalcul.last == "100")
    }

    func testAddNewNumberInMemoryOne() {
        calculates.addNewNumberInMem(1)
        calculates.addOperation(.soustraction)
        calculates.addNewNumberInMem(1)

        XCTAssertTrue(calculates.memTotals.last == "1-1")
    }

    func testAddNewNumberInMemoryEleven() {
        calculates.addNewNumberInMem(11)

        XCTAssertTrue(calculates.memTotals.last == "11")
    }

    func testMemory() {
        operationPlusMemory(1, .addition, 1)
        calculates.clear()
        operationPlusMemory(5, .addition, 6)
        calculates.clear()
        operationPlusMemory(150, .soustraction, 50)
        calculates.clear()
        

        XCTAssertTrue(calculates.memoryCalcul.first == "1+1=2")
        XCTAssertTrue(calculates.memoryCalcul.count == 3)
    }

}
