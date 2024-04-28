//
//  PropertiesSetup.swift
//  CountryInfo
//
//  Created by vako on 28.04.24.
//

import UIKit

class PropertiesSetup {
    
    static func setupTextField(placeholder: String, isSecureTextEntry: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.font = UIFont.systemFont(ofSize: 11)
        textField.isSecureTextEntry = isSecureTextEntry
        textField.textContentType = .oneTimeCode 
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = AppColors.customTextFieldBackgroundColor1
        return textField
    }

    
    static func setupLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func setupButton(title: String, backgroundColor: UIColor = .systemBlue) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    class AlertSetup {
        static func showAlert(on viewController: UIViewController, title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
