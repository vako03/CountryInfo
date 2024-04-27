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
    
    private let textFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "მომხმარებლის სახელი"
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "   შეიყვანეთ მომხმარებლის სახელი"
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.font = UIFont.systemFont(ofSize: 11)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = AppColors.customTextFieldBackgroundColor1
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "პაროლი"
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "   შეიყვანეთ პაროლი"
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.font = UIFont.systemFont(ofSize: 11)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = AppColors.customTextFieldBackgroundColor1
        
        return textField
    }()
    
    private let repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "გაიმეორეთ პაროლი"
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "   განმეორებით შეიყვანეთ პაროლი"
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.font = UIFont.systemFont(ofSize: 11)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = AppColors.customTextFieldBackgroundColor1
        return textField
    }()
    
    private let loginButton: UIButton = {
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
        imagePicker.allowsEditing = true
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
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
