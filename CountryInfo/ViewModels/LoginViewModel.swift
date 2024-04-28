//
//  LoginViewModel.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func loginSuccess()
    func loginError(message: String)
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    func login(username: String, password: String, repeatPassword: String) {
        guard !username.isEmpty, !password.isEmpty, !repeatPassword.isEmpty else {
            delegate?.loginError(message: "Please fill in all fields.")
            return
        }
        
        guard password == repeatPassword else {
            delegate?.loginError(message: "Passwords don't match.")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let credentials = UserCredentials(username: username, password: password)
            KeychainService.shared.saveUserCredentials(credentials)
            self.delegate?.loginSuccess()
        }
    }
}
