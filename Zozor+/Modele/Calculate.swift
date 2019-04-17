//
//  Calculate.swift
//  CountOnMe
//
//  Created by Clément Martin on 11/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation
import UIKit

class Calculate {
    
    // MARK: - Properties
    var stringNumbers: [String] = [String()]
    var operators: [Operator] = [.Addition]
    var index = 0
    var delegate: communicationAlert?
    var delegate1: updateDisplayCalcul?
    var total = calculateTotal
    
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty{
                if stringNumbers.count == 1{
                    delegate?.itIsAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                } else {
                    delegate?.itIsAlert(title: "Zéro", message: "Entrez une expression correcte !", preferredStyle: .alert)
                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
              delegate?.itIsAlert(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
                return false
            }
        }
        return true
    }
    
    
    func calculateTotal(){
        if !isExpressionCorrect{
            return
        }
            var total = 0
            for (i, stringNumber) in stringNumbers.enumerated() {
                if let number = Int(stringNumber) {
                    switch operators[i]{
                    case .Addition:
                        total += number
                    case .Soustraction:
                        total -= number
                    case .Multiplication:
                        total *= number
                    case .Division:
                        total /= number
                    }
                }
                
            }
            delegate1?.itIsResultt(total: total)
            
        }
    
        
    func clear() {
        stringNumbers = [String()]
        operators = [.Addition]
        index = 0
    }
    

 
 
}

protocol communicationAlert{
    func itIsAlert(title: String, message: String, preferredStyle: UIAlertController.Style)
}
protocol updateDisplayCalcul{
    func itIsResultt(total: Int)
    
}
