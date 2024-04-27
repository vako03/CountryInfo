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
    
    func login(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            delegate?.loginError(message: "Please fill in all fields.")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let credentials = UserCredentials(username: username, password: password)
            KeychainService.shared.saveUserCredentials(credentials)
            self.delegate?.loginSuccess()
        }
    }
}
