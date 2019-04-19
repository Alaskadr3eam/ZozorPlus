//
//  enumOperator.swift
//  CountOnMe
//
//  Created by Clément Martin on 12/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

enum Operator {
    case addition, soustraction, multiplication, division

    var displayString: String {
        switch self {
        case.addition:
            return "+"
        case.division:
            return "÷"
        case.multiplication:
            return "x"
        case.soustraction:
            return "-"
        }
    }
}
