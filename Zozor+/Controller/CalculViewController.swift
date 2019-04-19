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
    override func viewDidLoad() {
        calculates.delegateAlert = self
        calculates.delegateScreen = self
    }

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (index, numberButton) in numberButtons.enumerated() where sender == numberButton {
                calculates.addNewNumber(index)
            }
    }

    @IBAction func plus() {
        calculates.addition()
    }

    @IBAction func minus() {
       calculates.soustraction()
    }

    @IBAction func multi() {
        calculates.multiplication()
    }

    @IBAction func diviser() {
        calculates.division()
    }

    @IBAction func equal() {
        calculates.calculateTotal()
        calculates.clear()
    }

}
