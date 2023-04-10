//
//  NumberFormatter+Extensions.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import Foundation

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
