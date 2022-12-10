//
//  LoginViewController.swift
//  Netflix
//
//  Created by Gadirli on 10.11.22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "net")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şifrə"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Giriş et", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hesabın yoxdur? Yeni hesab yarat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .systemBackground
        view.addSubview(headerImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        addConstraints()
        loginButton.addTarget(self, action: #selector(performTabbar(_:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(performRegister(_:)), for: .touchUpInside)
        
        emailTextField.text = "babekqadirli@gmail.com"
        passwordTextField.text = "babek123"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            let tabVc = MainTabBarViewController()
            navigationController?.pushViewController(tabVc, animated: true)
        }
        emailTextField.becomeFirstResponder()
    }
    
    private func addConstraints() {
        
//        let headerViewConstraints = [
//            headerView.topAnchor.constraint(equalTo: view.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            headerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -580)
//        ]
        
        let headerImageConstraints = [
            headerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerImage.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let emailTextFiedConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 30)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30)
        ]
        
        
        let loginButtonConstraints = [
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
        ]
        
        let registerButtonConstraints = [
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        ]
        
        
        NSLayoutConstraint.activate(headerImageConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(emailTextFiedConstraints)
//        NSLayoutConstraint.activate(headerViewConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
    }
    
    @objc func performTabbar(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Missing fields")
            return
        }
        
        //Get auth instance
        //attempt sign in
        //if failure, present alert o create account
        //if user continues, create account
        
        
        //check sign in on appp launch
        //allow user to sign out with button
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] resut, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                strongSelf.showCreateAccount()
                return
            }
            
            print("User signed in")
            
            let tabVC = MainTabBarViewController()
            strongSelf.navigationController?.pushViewController(tabVC, animated: true)
            
            strongSelf.emailTextField.resignFirstResponder()
            strongSelf.passwordTextField.resignFirstResponder()
        }
        
        
    }
    
    @objc func performRegister(_ sender: UIButton) {
        print("Button clicked ")
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func showCreateAccount() {
        let alert = UIAlertController(title: "Hesab Yarat", message: "Belə hesab mövcud deyil. Yeni hesab yaratmaq istəyirsiniz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Davam et", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true)
    }


}



