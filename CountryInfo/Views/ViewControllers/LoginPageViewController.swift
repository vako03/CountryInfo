//
//  LoginPageViewController.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//

import UIKit

class LoginPageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private let viewModel = LoginViewModel()
    
    private let imagePicker = UIImagePickerController()
    
    private lazy var imageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profileImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setProfileImage), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldLabel: UILabel = {
        UILabel.makeLabel(text: "მომხმარებლის სახელი")
    }()
    
    private lazy var usernameTextField: UITextField = {
        UITextField.makeTextField(placeholder: "   შეიყვანეთ მომხმარებლის სახელი", isSecureTextEntry: false)
    }()
    
    private lazy var passwordLabel: UILabel = {
        UILabel.makeLabel(text: "პაროლი")
    }()
    
    private lazy var passwordTextField: UITextField = {
        UITextField.makeTextField(placeholder: "   შეიყვანეთ პაროლი", isSecureTextEntry: true)
    }()
    
    private lazy var repeatPasswordLabel: UILabel = {
        UILabel.makeLabel(text: "გაიმეორეთ პაროლი")
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        UITextField.makeTextField(placeholder: "   განმეორებით შეიყვანეთ პაროლი", isSecureTextEntry: true)
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("შესვლა", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.customBackgroundColor
        setupUI()
        viewModel.delegate = self
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    private func setupUI() {
        UIElements.setupLoginPageUI(in: view, imageView: imageView, textFieldLabel: textFieldLabel, usernameTextField: usernameTextField, passwordLabel: passwordLabel, passwordTextField: passwordTextField, repeatPasswordLabel: repeatPasswordLabel, repeatPasswordTextField: repeatPasswordTextField, loginButton: loginButton)
    }
    
    @objc private func loginButtonTapped() {
        guard let password = passwordTextField.text, !password.isEmpty,
              let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        guard password == repeatPassword else {
            showAlert(message: "Passwords don't match.")
            return
        }
        
        viewModel.login(username: usernameTextField.text ?? "",
                        password: password)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func setProfileImage() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.setImage(pickedImage, for: .normal)
            // Save image to Documents directory
            if let data = pickedImage.jpegData(compressionQuality: 0.8),
               let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("profileImage.jpg") {
                try? data.write(to: url)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension LoginPageViewController: LoginViewModelDelegate {
    func loginSuccess() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
        if !UserDefaults.standard.bool(forKey: "hasLoggedInBefore") {
            UserDefaults.standard.set(true, forKey: "hasLoggedInBefore")
            let alert = UIAlertController(title: "Welcome", message: "You have successfully logged in for the first time", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func loginError(message: String) {
        showAlert(message: message)
    }
}

