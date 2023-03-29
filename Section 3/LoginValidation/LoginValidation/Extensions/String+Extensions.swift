//
//  String+Extensions.swift
//  LoginValidation
//
//  Created by Amin Siddiqui on 29/03/23.
//

import Foundation

extension String {
    
    var isEmail: Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        return self.range(of: emailPattern, options: .regularExpression) != nil
    }
}
