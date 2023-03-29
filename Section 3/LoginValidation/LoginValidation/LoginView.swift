//
//  LoginView.swift
//  LoginValidation
//
//  Created by Amin Siddiqui on 29/03/23.
//

import SwiftUI

struct LoginView: View {
    
    @State
    private var email: String = ""
    @State
    private var password: String = ""
    
    var isFormValid: Bool {
        email.isEmail && password.count >= 2
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
            }
            
            Button("Login") {
                print(#function)
            }
            .disabled(!isFormValid)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
