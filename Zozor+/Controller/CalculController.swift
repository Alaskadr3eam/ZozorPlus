//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class CalculController: UIViewController, communicationAlert, updateDisplayCalcul  {
    
    var calculates = Calculate()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    override func viewDidLoad() {
        calculates.delegate = self
        calculates.delegate1 = self
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton){
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                addNewNumber(i)
            }
        }
        
    }
    
    func addNewNumber(_ newNumber: Int){
        if let stringNumber = calculates.stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            calculates.stringNumbers[calculates.stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }
    
    func updateDisplay() {
        var text = ""
        for (i, stringNumber) in calculates.stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += calculates.operators[i].displayString
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }
    
    
 
    func itIsResultt(total: Int) {
        textView.text = textView.text + "=\(total)"
        
    }
    
    func itIsAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        alertVC(title: title, message: message, preferredStyle: preferredStyle)
    }
    
    @IBAction func plus() {
        if calculates.canAddOperator {
            calculates.operators.append(.Addition)
            calculates.stringNumbers.append("")
            updateDisplay()
        }
    }
    
    @IBAction func minus() {
        if calculates.canAddOperator {
            calculates.operators.append(.Soustraction)
            calculates.stringNumbers.append("")
            updateDisplay()
        }
    }
    
    @IBAction func multi(){
        if calculates.canAddOperator{
            calculates.operators.append(.Multiplication)
            calculates.stringNumbers.append("")
            updateDisplay()
        }
    }
    
    @IBAction func diviser(){
        if calculates.canAddOperator{
            calculates.operators.append(.Division)
            calculates.stringNumbers.append("")
            updateDisplay()
        }
    }
    
    @IBAction func equal() {
        calculates.calculateTotal()
        calculates.clear()
    }



}

extension UIViewController {
    func alertVC(title: String, message: String, preferredStyle: UIAlertController.Style){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}


