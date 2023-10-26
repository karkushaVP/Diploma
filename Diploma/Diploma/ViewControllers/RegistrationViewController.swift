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
    
    private lazy var underImage: UIView = {
        let view = UIView()
        return view
    }()
    
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
    
    private lazy var loginStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        return stack
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
        label.font = .systemFont(ofSize: 10)
        label.isHidden = false
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
        
        if let userId = Auth.auth().currentUser?.uid {
            print("Залогинен пользователь: \(userId)")
        } else {
            print("Пользователь не залогинен")
        }
    }
    
    private func makeLayout() {
        self.view.addSubview(underImage)
        underImage.addSubview(coverImage)
        self.view.addSubview(mainLabel)
        self.view.addSubview(loginStack)
        loginStack.addArrangedSubview(loginInput)
        loginStack.addArrangedSubview(passwordInput)
        loginStack.addArrangedSubview(errorLabel)
        self.view.addSubview(loginButton)
        self.view.addSubview(registrationButton)
    }
    
    private func makeConstraints() {
        
        underImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(55)
        }
        
        loginStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        loginInput.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        passwordInput.snp.makeConstraints { make in
            make.height.equalTo(40)
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
                print(error!.localizedDescription)
                self?.view.backgroundColor = .red
                return
            }
            
            self?.view.backgroundColor = .green
//            self?.navigationController?.pushViewController(ProfileController(), animated: true)
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
            
            self?.view.backgroundColor = .green
        }
    }
}
