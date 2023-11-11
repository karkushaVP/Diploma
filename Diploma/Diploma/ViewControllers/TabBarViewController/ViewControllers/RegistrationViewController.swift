//
//  RegisterationViewController.swift
//  Diploma
//
//  Created by Polya on 23.10.23.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "registr"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "TO DO LIST"
        label.textColor = .systemTeal
        label.font = UIFont.italicSystemFont(ofSize: 55.0)
        return label
    }()
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white.withAlphaComponent(0.7)
        return view
    }()
    
    private lazy var loginInput: UITextField = {
        let input = UITextField()
        input.layer.cornerRadius = 10
        input.layer.borderColor = UIColor.systemTeal.cgColor
        input.layer.borderWidth = 2
        input.leftViewMode = .always
        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        input.placeholder = "Логин"
        return input
    }()
    
    private lazy var passwordInput: UITextField = {
        let input = UITextField()
        input.layer.cornerRadius = 10
        input.layer.borderColor = UIColor.systemTeal.cgColor
        input.layer.borderWidth = 2
        input.leftViewMode = .always
        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        input.placeholder = "Пароль"
        return input
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Неверный логин или пароль"
        label.font = .systemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemTeal.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemTeal.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(registration), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        if let userId = Auth.auth().currentUser?.uid {
            print("Залогинен пользователь: \(userId)")
        } else {
            print("Пользователь не залогинен")
        }
    }
    
    private func makeLayout() {
        
        self.view.addSubview(coverImage)
        self.view.addSubview(mainLabel)
        self.view.addSubview(loginView)
        loginView.addSubview(loginInput)
        loginView.addSubview(passwordInput)
        self.view.addSubview(errorLabel)
        self.view.addSubview(loginButton)
        self.view.addSubview(registrationButton)
    }
    
    private func makeConstraints() {
        
        coverImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(55)
        }
        
        loginView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        loginInput.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
//
        passwordInput.snp.makeConstraints { make in
            make.top.equalTo(loginInput.snp.bottom).offset(10)
            make.leading.equalTo(loginInput.snp.leading)
            make.trailing.equalTo(loginInput.snp.trailing)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(registrationButton.snp.top).inset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    
    @objc private func login() {
        guard let login = loginInput.text,
              let password = passwordInput.text
        else { return }
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] result, error in
            guard error == nil,
                  let result
            else {
                self?.errorLabel.isHidden = false
                return
            }
            UIApplication.shared.keyWindow?.rootViewController = TabBarViewController(currentUserId: result.user.uid)
        }
    }
    
    @objc private func registration() {
        guard let login = loginInput.text,
              let password = passwordInput.text
        else { return }
        
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] result, error in
            guard error == nil,
                  let result
            else {
                print(error!.localizedDescription)
                self?.view.backgroundColor = .red
                return
            }
            self?.present(ProfileViewController(mode: .create), animated:true, completion: nil)
        }
    }
}

extension RegistrationViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
