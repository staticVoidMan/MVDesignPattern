//
//  String+Extensions.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 03/04/23.
//

import Foundation

extension String {
    
    var isNumeric: Bool {
        Double(self) != nil
    }
}
