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
    
    @Published var errors: [LoginError] = []
    
    private var isPasswordValid: Bool {
        password.count >= 3
    }
    
    var isFormValid: Bool {
        errors.removeAll()
        
        if email.isEmpty {
            errors.append(.emailIsEmpty)
        } else if !email.isEmail {
            errors.append(.emailIsInvalid)
        }
        
        if !isPasswordValid {
            errors.append(.passwordIsInvalid)
        }
        
        return errors.isEmpty
    }
}

struct LoginView: View {
    
    @StateObject
    private var viewModel: LoginViewModel = .init()
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $viewModel.password)
                }
                
                Section {
                    ForEach(viewModel.errors, id: \.hashValue) { error in
                        Text(error.localizedDescription)
                            .font(.caption)
                    }
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
