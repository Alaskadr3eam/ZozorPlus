//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class CalculViewController: UIViewController {

    var calculates = Calculate()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    override func viewDidLoad() {
        calculates.delegateAlert = self
        calculates.delegateScreen = self
    }

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (index, numberButton) in numberButtons.enumerated() where sender == numberButton {
                calculates.addNewNumber(index)
            }
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
            switch sender.tag {
            case 1:
                calculates.addOperation(.addition)
            case 2:
                calculates.addOperation(.soustraction)
            case 3:
                calculates.addOperation(.multiplication)
            case 4:
                calculates.addOperation(.division)
            default: break
            }
    }

    @IBAction func equal() {
        calculates.calculateTotal()
        calculates.clear()
    }

}
