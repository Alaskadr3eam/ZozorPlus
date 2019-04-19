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
    var stringNumbers: [String] = [String()]
    var operators: [Operator] = [.addition]
    var index1 = 0
    var delegateAlert: CommunicationAlert?
    var delegateScreen: UpdateDisplayCalcul?
   // var total = calculateTotal

    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
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

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    func updateDisplay() {
        var text = ""
        for (index, stringNumber) in  stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index].displayString
            }
            // Add number
            text += stringNumber
        }
        delegateScreen?.itIsToDisplay(text: text)
    }

    func operation(_ sign: Operator) {
        if canAddOperator {
            operators.append(sign)
            stringNumbers.append("")
            updateDisplay()
        }
    }

    func addition() {
        operation(.addition)
    }

    func soustraction() {
       operation(.soustraction)
    }

    func multiplication() {
        operation(.multiplication)
    }

    func division() {
        operation(.division)
    }

    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
            var total = 0
            for (index, stringNumber) in stringNumbers.enumerated() {
                if let number = Int(stringNumber) {
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
            delegateScreen?.itIsResultt(total: total)
        }

    func clear() {
        stringNumbers = [String()]
        operators = [.addition]
        index1 = 0
    }
}

protocol CommunicationAlert {
    func itIsAlert(title: String, message: String)
}

protocol UpdateDisplayCalcul {
    func itIsResultt(total: Int)
    func itIsToDisplay(text: String)
}
