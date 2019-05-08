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

    func operation(_ one:Int,_ sign:Operator,_ two:Int) {
        calculates.addNewNumberEveryWhere(one)
        calculates.addOperation(sign)
        calculates.addNewNumberEveryWhere(two)
        calculates.calculateTotal()
    }

    func operationCompare(_ one:Int,_ sign:Operator,_ two:Int) {
        calculates.addNewNumberEveryWhere(one)
        calculates.addOperation(sign)
        calculates.addNewNumberEveryWhere(two)
        calculates.addPointZeroIfNesserayForCalcul()
    }

    func verfiyPriorityRulesCalcul(_ one: Int,_ sign: Operator,_ two: Int,_ sign2: Operator,_ three: Int) {
        calculates.addNewNumberEveryWhere(one)
        calculates.addOperation(sign)
        calculates.addNewNumberEveryWhere(two)
        calculates.addOperation(sign2)
        calculates.addNewNumberEveryWhere(three)
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

        XCTAssertFalse(calculates.total == 2)
        XCTAssertTrue(calculates.total == 2.5)
    }

    func testtestGivenOperation_WhenSixAndFiveAreMultiplied_ThenResultShouldBeThirty() {

        operation(5, .multiplication, 6)

        //XCTAssert(calculates.total == 30)
        XCTAssertFalse(calculates.total == 35)
        XCTAssertTrue(calculates.total == 30)
    }

    func testClear() {
        operation(5, .soustraction, 6)
        calculates.total = -1.0

        calculates.clear()

        XCTAssertTrue(calculates.stringNumbers == [String]())
        XCTAssertTrue(calculates.operators == [.addition])
        XCTAssertTrue(calculates.total == Double())
        XCTAssertTrue(calculates.calculFinal == String())
        XCTAssertTrue(calculates.memTotals == String())
        XCTAssertEqual(calculates.calculFinal, calculates.memTotals)
    }

    func testAddMem() {
        calculates.addMem("100")

        XCTAssertTrue(calculates.memoryCalcul.last == "100")
    }

    func testAddNewNumberInMemoryOne() {
        calculates.addNewNumberInMem(1)
        calculates.addOperatorMem("-")
        calculates.addNewNumberInMem(1)

        XCTAssertNil(calculates.memoryCalcul.last)
        XCTAssertTrue(calculates.memTotals == "1-1")
    }

    func testAddNewNumberInMemoryEleven() {
        calculates.addNewNumberInMem(11)

        XCTAssertTrue(calculates.memTotals == "11")
    }

    func testMemory() {
        operation(1, .addition, 1)
        calculates.clear()
        operation(5, .addition, 6)
        calculates.clear()
        operation(150, .soustraction, 50)
        calculates.clear()

        XCTAssertTrue(calculates.memoryCalcul.last == "150-50=100")
        XCTAssertTrue(calculates.memoryCalcul.first == "1+1=2")
        XCTAssertTrue(calculates.memoryCalcul.count == 3)
    }

    func testGivenAddPointInFormuleFotCalcul() {
        operationCompare(1, .addition, 1)

        XCTAssertFalse(calculates.memTotals == calculates.calculFinal)
        XCTAssertTrue(calculates.memTotals == "1+1")
        XCTAssertTrue(calculates.calculFinal == "1+1.0")
    }
    // MARK: - test suite de calcul pour la priorité
    func testOnePlusFive() {
        operation(1, .addition, 5)

        XCTAssertTrue(calculates.total == 6)
    }

    func testSixDivide2() {
        operation(6, .division, 2)

        XCTAssertTrue(calculates.total == 3)
    }

    func testOperationOnePlusFiveDividedByTwo() {
        verfiyPriorityRulesCalcul(1, .addition, 5, .division, 2)

        XCTAssertTrue(calculates.total == 3.5)
    }

}
