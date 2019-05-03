//
//  protocoleUpdateDisplay.swift
//  CountOnMe
//
//  Created by Clément Martin on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

extension CalculViewController: UpdateDisplayCalcul {

    func itIsResultt(total: String) {

        textView.text += "=\(total)"
       // calculates.addMem(result: textView.text)
    }

    func itIsToDisplay(text: String) {
        textView.text = text
    }
}
