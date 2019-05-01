//
//  protocoleUpdateDisplay.swift
//  CountOnMe
//
//  Created by Clément Martin on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

extension CalculViewController: UpdateDisplayCalcul {

    func itIsResultt(total: Double) {

        textView.text += "=\(total.formatToString())"
        calculates.addMem(result: textView.text)
        /*let result = textView.text
        if !calculates.memoryIsFull {
            return
        }
        calculates.memTotals.append(result!)*/
    }

    func itIsToDisplay(text: String) {
        textView.text = text
    }
}

// textView.text = textView.text + "=\(total)"
