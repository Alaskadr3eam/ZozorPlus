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

    func testIsExpressionCorrect() {
    }

    func testAddOperator() {

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

        operation(5, .division, 6)

        XCTAssert(calculates.total == 0)
    }

    func testtestGivenOperation_WhenSixAndFiveAreMultiplied_ThenResultShouldBeThirty() {

        operation(5, .multiplication, 6)

        //XCTAssert(calculates.total == 30)
        XCTAssertTrue(calculates.total == 30)
        XCTAssertFalse(calculates.total == 20)
    }

    func testGivenMemoire_WhenOperationFinished_ThenOperationIsStockedMemories() {

        operation(5, .addition, 6)
        calculates.clear()
        operation(6, .addition, 6)
        calculates.clear()

        XCTAssert(calculates.memTotals.last == "5+6=11")

    }

    func testClear() {
        operation(5, .soustraction, 6)
        calculates.total = -1

        calculates.clear()

        XCTAssertTrue(calculates.stringNumbers == [String()])
        XCTAssertTrue(calculates.operators == [.addition])
        XCTAssertTrue(calculates.total == 0)
    }

}