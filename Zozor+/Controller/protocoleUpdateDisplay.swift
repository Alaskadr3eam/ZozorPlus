//
//  protocoleUpdateDisplay.swift
//  CountOnMe
//
//  Created by Clément Martin on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

extension CalculViewController: updateDisplayCalcul{
    
    func itIsResultt(total: Int) {
        textView.text = textView.text + "=\(total)"
        
    }
    
}

