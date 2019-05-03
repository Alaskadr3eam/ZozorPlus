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

    @IBAction func bouton(_ sender: UIButton) {
        let index = sender.tag - 100
        calculates.addNewNumberEveryWhere(index)
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
            case 5:
                calculates.calculateTotal()
                calculates.clear()
            case 6:
                calculates.choiceMemory()
            default: break
            }
    }

}
