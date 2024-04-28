//
//  LoginPageViewController.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//
import UIKit

class LoginPageViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    fileprivate lazy var imagePickerHandler: ImagePickerHandler = {
        return ImagePickerHandler(viewController: self)
    }()
    
    internal lazy var imageView: UIButton = {
        let button = PropertiesSetup.setupButton(title: "", backgroundColor: .clear)
        button.setImage(UIImage(named: "profileImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setProfileImage(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldLabel: UILabel = PropertiesSetup.setupLabel(text: "მომხმარებლის სახელი")
    
    private lazy var usernameTextField: UITextField = PropertiesSetup.setupTextField(placeholder: "   შეიყვანეთ მომხმარებლის სახელი")
    
    private lazy var passwordLabel: UILabel = PropertiesSetup.setupLabel(text: "პაროლი")
    
    private lazy var passwordTextField: UITextField = PropertiesSetup.setupTextField(placeholder: "   შეიყვანეთ პაროლი", isSecureTextEntry: true)
    
    private lazy var repeatPasswordLabel: UILabel = PropertiesSetup.setupLabel(text: "გაიმეორეთ პაროლი")
    
    private lazy var repeatPasswordTextField: UITextField = PropertiesSetup.setupTextField(placeholder: "   განმეორებით შეიყვანეთ პაროლი", isSecureTextEntry: true)
    
    private lazy var loginButton: UIButton = {
        let button = PropertiesSetup.setupButton(title: "შესვლა")
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.customBackgroundColor
        setupUI()
        
        viewModel.delegate = self
        
        // Set text field delegates
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(textFieldLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordLabel)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 47),
            textFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            usernameTextField.topAnchor.constraint(equalTo: textFieldLabel.bottomAnchor, constant: 6),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 31),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 6),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            repeatPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 31),
            repeatPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: repeatPasswordLabel.bottomAnchor, constant: 6),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    @objc private func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        viewModel.login(username: username, password: password, repeatPassword: repeatPassword)
    }
    
    @objc private func setProfileImage(_ sender: UIButton) {
        imagePickerHandler.showImagePickerController()
    }
    
    private func showAlert(message: String) {
        PropertiesSetup.AlertSetup.showAlert(on: self, title: "Alert", message: message)
    }
}

// MARK: - UITextFieldDelegate

extension LoginPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - LoginViewModelDelegate

extension LoginPageViewController: LoginViewModelDelegate {
    func loginSuccess() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        let viewController = CountriesViewController()
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
