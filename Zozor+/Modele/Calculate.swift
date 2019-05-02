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
           // if memTotal.isEmpty {
           //     if memTotals.isEmpty {
                    delegateAlert?.itIsAlert(title: "Rien", message: "Faite un premier calcul !")
                  return false
                }
        return true
    }

    var memoryIsFull: Bool {
        if memTotals.count == 8 {
            delegateAlert?.itIsAlert(title: "Attention", message: "plus que deux calculs avant effacement de la mémoire")
            return true
        }
        if memTotals.count == 10 {
            delegateAlert?.itIsAlert(title: "Attention", message: "mémoire effacé")
            memTotals = [String]()
            return true
        }
        return true
    }

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

    func addOperation(_ sign: Operator) {
        if canAddOperator {
            operators.append(sign)
            stringNumbers.append("")
            updateDisplay()
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
            delegateScreen?.itIsResultt(total: total)
        }

    private func accessResultInMem() {
        if !canAccessTheMemory {
            return
        }
        let text = memTotals[indexMem]
        delegateScreen?.itIsToDisplay(text: text)
    }

    func choiceMemory() {
        if indexMem <= memTotals.count - 1 {
            accessResultInMem()
            indexMem += 1
        } else {
            indexMem = 0
            accessResultInMem()
            indexMem += 1
        }
    }

    func clear() {
        total = 0
        stringNumbers = [String()]
        operators = [.addition]
    }

    func addMem(result: String ) {
        let result = result
        if !memoryIsFull {
            return
        }
        memTotals.append(result)
    }
}

protocol CommunicationAlert {
    func itIsAlert(title: String, message: String)
}

protocol UpdateDisplayCalcul {
    func itIsResultt(total: Double)
    func itIsToDisplay(text: String)
}

