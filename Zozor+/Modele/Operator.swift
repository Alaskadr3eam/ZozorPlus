//
//  enumOperator.swift
//  CountOnMe
//
//  Created by Clément Martin on 12/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

enum Operator {
    case Addition, Soustraction, Multiplication, Division
    
    var displayString: String{
        switch self {
        case.Addition:
            return "+"
        case.Division:
            return "÷"
        case.Multiplication:
            return "x"
        case.Soustraction:
            return "-"
        }
    }
}
