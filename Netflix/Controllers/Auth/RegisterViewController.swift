//
//  RegisterViewController.swift
//  Netflix
//
//  Created by Gadirli on 11.11.22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    private var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilepic")
       
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ad"
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
    
    private var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Soyad"
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
    
    private var password2TextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şifrəni təsdiqlə"
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Hesab Yarat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .systemBackground
        view.addSubview(headerImage)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(password2TextField)
        view.addSubview(registerButton)
        addConstraints()
        registerButton.addTarget(self, action: #selector(performTabbar(_:)), for: .touchUpInside)
        
        headerImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
        headerImage.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerImage.layer.cornerRadius = headerImage.frame.size.width / 2
        
        headerImage.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    @objc private func didTapChangeProfilePicture() {
        presentPhotoActionShit()
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
            headerImage.heightAnchor.constraint(equalToConstant: 90),
            headerImage.widthAnchor.constraint(equalToConstant: 90)
        ]
        
        let nameTextFieldConstraints = [
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 20)
        ]
        
        let surnameTextFieldConstraints = [
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20)
        ]
        
        let emailTextFiedConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20)
        ]
        
        let password2TextFieldConstraints = [
            password2TextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            password2TextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password2TextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ]
        
        
        let loginButtonConstraints = [
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.topAnchor.constraint(equalTo: password2TextField.bottomAnchor, constant: 20)
        ]
        
        
        NSLayoutConstraint.activate(headerImageConstraints)
        NSLayoutConstraint.activate(nameTextFieldConstraints)
        NSLayoutConstraint.activate(surnameTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(emailTextFiedConstraints)
//        NSLayoutConstraint.activate(headerViewConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
        NSLayoutConstraint.activate(password2TextFieldConstraints)
    }
    
    @objc func performTabbar(_ sender: UIButton) {
        
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, let password2 = password2TextField.text, !password2.isEmpty else {
            print("Missing fields")
            return
        }
        
        if password != password2 {
            
            showCreateAccount(title: "Xəta", message: "Şifrələr uyğun gəlmir")
            return
        }
        
        
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] resut, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                strongSelf.showCreateAccount(title: "Xəta", message: "Hesab yaratmaq mümkün olmadı")
                return
            }
            
            print("User signed in")
            strongSelf.showCreateAccount(title: "Hesab yaradıldı", message: "Yeni hesab yaradıldı. Xahiş olunur giriş edin")
            
            let netflixUser = NetflixUser(firstName: name, lastName: surname, emailAddress: email)
            
            DBManager.shared.addUser(with: netflixUser) { done in
                if done {
                    //Upload photo
                    guard let image = strongSelf.headerImage.image, let data = image.pngData() else {
                        return
                    }
                    
                    let fileName = netflixUser.profilePictureFileName
                    
                    StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName) { result in
                        switch result {
                        case .success(let downloadUrl):
                            UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                            print(downloadUrl)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }

            }
            
            
            let tabVC = MainTabBarViewController()
            tabVC.modalPresentationStyle = .fullScreen
            strongSelf.present(tabVC, animated: true, completion: nil)
            
            strongSelf.emailTextField.resignFirstResponder()
            strongSelf.passwordTextField.resignFirstResponder()
        }
        
        
    }
    
    func showCreateAccount(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oldu", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionShit() {
        let actionSheet = UIAlertController(title: "Profil şəkili", message: "Profil şəklini təyin et", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Ləğv et", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Qalereyadan seç", style: .default, handler: {[weak self] _ in
            self?.presentPhotoLibrary()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.headerImage.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
