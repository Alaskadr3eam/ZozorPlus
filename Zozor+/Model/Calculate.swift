//
//  Calculate.swift
//  CountOnMe
//
//  Created by Clément Martin on 11/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculate {

    // MARK: - Properties
    var stringNumbers: [String] = [String]()
    var operators: [Operator] = [.addition]
    var indexMem = 0
    var delegateAlert: CommunicationAlert?
    var delegateScreen: UpdateDisplayCalcul?
    var total = 0.0
    var memTotals: [String] = [String]()
    var memoryCalcul: [String] = [String]()

     var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.isEmpty {
                    delegateAlert?.itIsAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
                } else {
                    delegateAlert?.itIsAlert(title: "Zéro", message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
              delegateAlert?.itIsAlert(title: "Zéro!", message: "Expression incorrecte !")
                return false
            }
        }
        return true
    }

    var canAccessTheMemory: Bool {
        if memTotals.isEmpty {
                    delegateAlert?.itIsAlert(title: "Rien", message: "Faite un premier calcul !")
                  return false
                }
        return true
    }

    // MARK: - Func operation
    func addNewNumber(_ newNumber: Int) {
        if stringNumbers.count == 0 {
            let stringNumber = "\(newNumber)"
            stringNumbers.append(stringNumber)
        } else if newNumber == 10 {
            if let stringNumber = stringNumbers.last {
                var stringNumberMutable = stringNumber
                stringNumberMutable += "."
                stringNumbers[stringNumbers.count - 1] = stringNumberMutable
            }
        } else {
            if let stringNumber = stringNumbers.last {
                var stringNumberMutable = stringNumber
                stringNumberMutable += "\(newNumber)"
                stringNumbers[stringNumbers.count - 1] = stringNumberMutable
            }
        }
        updateDisplay()
    }

    func addNewNumberEveryWhere(_ newNumber: Int) {
        addNewNumber(newNumber)
        addNewNumberInMem(newNumber)
    }

    func addOperation(_ sign: Operator) {
        if canAddOperator {
            operators.append(sign)
            stringNumbers.append("")
            updateDisplay()
            switch sign {
            case.addition:
                canAddOperatorMem("+")
            case.soustraction:
                canAddOperatorMem("-")
            case.division:
                canAddOperatorMem("÷")
            case.multiplication:
                canAddOperatorMem("x")
            }
        }
    }

    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
            for (index, stringNumber) in stringNumbers.enumerated() {
                if let number = Double(stringNumber) {
                    switch operators[index] {
                    case .addition:
                        total += number
                    case .soustraction:
                        total -= number
                    case .multiplication:
                        total *= number
                    case .division:
                        total /= number
                    }
                }
            }
        totalRecoveryForMem(total)
            delegateScreen?.itIsResultt(total: total.formatToString())
        }

    // MARK: - Func Display
    func updateDisplay() {
        var text = ""
        for (index2, stringNumber) in  stringNumbers.enumerated() {
            if index2 > 0 {
                //add operator
                text += operators[index2].displayString
            }
            // Add number
            text += stringNumber
        }
        delegateScreen?.itIsToDisplay(text: text)
    }

    // MARK: - Func Memory
    func canAddOperatorMem(_ signOperator: String) {
        if let stringNumberMem = memTotals.last {
            var stringNumberMemMutable = stringNumberMem
            stringNumberMemMutable += signOperator
            memTotals[memTotals.count - 1] = stringNumberMemMutable
        }
    }

    func addNewNumberInMem(_ newNumberMem: Int) {
        if memTotals.count == 0 {
            let stringNumberMem = "\(newNumberMem)"
            memTotals.append(stringNumberMem)
        } else if newNumberMem == 10 {
            if let stringNumberMem = memTotals.last {
                var stringNumberMemMutable = stringNumberMem
                stringNumberMemMutable += "."
                memTotals[memTotals.count - 1] = stringNumberMemMutable
            }
        } else {
            if let stringNumberMem = memTotals.last {
                var stringNumberMemMutable = stringNumberMem
                stringNumberMemMutable += "\(newNumberMem)"
                memTotals[memTotals.count - 1] = stringNumberMemMutable
            }
        }
    }

    func totalRecoveryForMem(_ result: Double) {
        if let stringNumberMem = memTotals.last {
            var stringNumberMemMutable = stringNumberMem
            stringNumberMemMutable += "=\(result.formatToString())"
            memTotals[memTotals.count - 1] = stringNumberMemMutable
            addMem(stringNumberMemMutable)
        }
    }

    func accessResultInMem() {
        checkMemoryFull()
        let text = memoryCalcul[indexMem]
        delegateScreen?.itIsToDisplay(text: text)
    }

    func checkMemoryFull() {
        let number = memoryCalcul.count
        switch number {
        case 8:
            delegateAlert?.itIsAlert(title: "Attention", message: "plus que deux calculs avant effacement de la mémoire")
        case 10:
            delegateAlert?.itIsAlert(title: "Attention", message: "mémoire effacé")
            memoryCalcul = [String]()
        default : return
        }
    }

    func choiceMemory() {
        if indexMem <= memoryCalcul.count - 1 {
            accessResultInMem()
            indexMem += 1
        } else {
            indexMem = 0
            accessResultInMem()
            indexMem += 1
        }
    }

    func addMem(_ result: String ) {
        let result = result
        checkMemoryFull()
        memoryCalcul.append(result)
    }

    // MARK - Func clear re-init
    func clear() {
        total = 0
        stringNumbers = [String]()
        operators = [.addition]
        memTotals = [String]()
    }
}

protocol CommunicationAlert {
    func itIsAlert(title: String, message: String)
}

protocol UpdateDisplayCalcul {
    func itIsResultt(total: String)
    func itIsToDisplay(text: String)
}
