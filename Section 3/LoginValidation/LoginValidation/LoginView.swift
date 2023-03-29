//
//  LoginView.swift
//  LoginValidation
//
//  Created by Amin Siddiqui on 29/03/23.
//

import SwiftUI

struct LoginViewError {
    var email: String = ""
    var password: String = ""
}

struct LoginView: View {
    
    @State
    private var email: String = ""
    
    @State
    private var password: String = ""
    
    @State
    private var error: LoginViewError = .init()
    
    var isFormValid: Bool {
        let isPasswordLengthValid = password.count >= 3
        
        self.error = {
            var error = LoginViewError()
            error.email = {
                if email.isEmpty {
                    return "Email not specified"
                } else if !email.isEmail {
                    return "Email is invalid"
                } else {
                    return ""
                }
            }()
            error.password = isPasswordLengthValid ? "" : "Password is incomplete"
            return error
        }()
        
        return email.isEmail && isPasswordLengthValid
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                
                if !error.email.isEmpty {
                    Text(error.email)
                        .font(.caption)
                }
                
                SecureField("Password", text: $password)
                
                if !error.password.isEmpty {
                    Text(error.password)
                        .font(.caption)
                }
            }
            
            Button("Login") {
                if isFormValid {
                    print(#function)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
