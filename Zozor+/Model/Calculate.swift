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
    var calculFinal = String()
    var memTotals = String()
    var total = Double()
    var memoryCalcul: [String] = [String]()

     var isExpressionCorrect: Bool {
        if stringNumbers.last?.isEmpty == true || stringNumbers.count == 0 {
                if stringNumbers.isEmpty {
                    delegateAlert?.itIsAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
                } else {
                    delegateAlert?.itIsAlert(title: "Zéro", message: "Entrez une expression correcte !")
                }
                return false
        }
        return true
    }

    var canAddOperator: Bool {
        if stringNumbers.count == 0 || stringNumbers.last?.isEmpty == true {
              delegateAlert?.itIsAlert(title: "Zéro!", message: "Expression incorrecte !")
                return false
        }
        return true
    }

    var canAccessTheMemory: Bool {
        if memoryCalcul.isEmpty {
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

    func canAddOperatorDisplay(_ signOperator: String) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += signOperator
            memTotals = stringNumberMutable
        }
    }

    func addOperation(_ sign: Operator) {
        if canAddOperator {
            operators.append(sign)
            stringNumbers.append("")
            updateDisplay()
            switch sign {
            case.addition:
                addOperatorMem("+")
            case.soustraction:
                addOperatorMem("-")
            case.division:
                addOperatorMem("/")
            case.multiplication:
                addOperatorMem("*")
            }
        }
    }
//function to add .0 to the last number of the calculation so that the result is in decimal if necessary
    func addPointZeroIfNesserayForCalcul() {
        let letters = CharacterSet.init(charactersIn: ".")
        let range = memTotals.rangeOfCharacter(from: letters)
        if range != nil {
            calculFinal = memTotals
        } else {
            let stringNumberMem = memTotals
            var stringNumberMemMutable = stringNumberMem
            stringNumberMemMutable += ".0"
            calculFinal = stringNumberMemMutable
            }
    }

    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        addPointZeroIfNesserayForCalcul()
        let mathExpression = NSExpression(format: calculFinal)
        guard let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double else { return }
        total = mathValue
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
    func addOperatorMem(_ signOperator: String) {
            let stringNumberMem = memTotals
            var stringNumberMemMutable = stringNumberMem
            stringNumberMemMutable += signOperator
            memTotals = stringNumberMemMutable
    }

    func addNewNumberInMem(_ newNumberMem: Int) {
        if memTotals.isEmpty {
            let stringNumberMem = "\(newNumberMem)"
            memTotals = stringNumberMem
        } else if newNumberMem == 10 {
            let stringNumberMem = memTotals
                var stringNumberMemMutable = stringNumberMem
                stringNumberMemMutable += "."
            memTotals = stringNumberMemMutable
        } else {
            let stringNumberMem = memTotals
            var stringNumberMemMutable = stringNumberMem
            stringNumberMemMutable += "\(newNumberMem)"
            memTotals = stringNumberMemMutable
            }
    }

    func totalRecoveryForMem(_ result: Double) {
           let stringNumberMem = memTotals
            var stringNumberMemMutable = stringNumberMem
            stringNumberMemMutable += "=\(result.formatToString())"
            memTotals = stringNumberMemMutable
            addMem(stringNumberMemMutable)
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

    // MARK: - Func clear re-init
    func clear() {
        stringNumbers = [String]()
        operators = [.addition]
        memTotals = String()
        calculFinal = String()
        total = Double()
    }
}

protocol CommunicationAlert {
    func itIsAlert(title: String, message: String)
}

protocol UpdateDisplayCalcul {
    func itIsResultt(total: String)
    func itIsToDisplay(text: String)
}
