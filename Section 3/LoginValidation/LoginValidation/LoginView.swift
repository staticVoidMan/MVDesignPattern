//
//  LoginView.swift
//  LoginValidation
//
//  Created by Amin Siddiqui on 29/03/23.
//

import SwiftUI

enum LoginError: Error, LocalizedError {
    case emailIsEmpty
    case emailIsInvalid
    case passwordIsInvalid
    
    var errorDescription: String? {
        switch self {
        case .emailIsEmpty:
            return "Email should not be empty"
        case .emailIsInvalid:
            return "Email should be valid"
        case .passwordIsInvalid:
            return "Password should be atleast 3 characters"
        }
    }
}

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var emailError: LoginError? = nil
    @Published var passwordError: LoginError? = nil
    
    private var isPasswordValid: Bool {
        password.count >= 3
    }
    
    var isFormValid: Bool {
        emailError = {
            if email.isEmpty {
                return .emailIsEmpty
            } else if !email.isEmail {
                return .emailIsInvalid
            } else {
                return nil
            }
        }()
        
        passwordError = isPasswordValid ? nil : .passwordIsInvalid
        
        return emailError != nil && passwordError != nil
    }
}

struct LoginView: View {
    
    @StateObject
    private var viewModel: LoginViewModel = .init()
    
    var body: some View {
        VStack {
            Form {
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                
                if let error = viewModel.emailError {
                    Text(error.localizedDescription)
                        .font(.caption)
                }
                
                SecureField("Password", text: $viewModel.password)
                
                if let error = viewModel.passwordError {
                    Text(error.localizedDescription)
                        .font(.caption)
                }
            }
            
            Button("Login") {
                if viewModel.isFormValid {
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
