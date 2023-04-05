//
//  NumberFormatter.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 05/04/23.
//

import Foundation

extension NumberFormatter {
    
    static var currencyFormat: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
