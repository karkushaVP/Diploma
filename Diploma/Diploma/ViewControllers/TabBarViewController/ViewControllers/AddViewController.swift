//
//  AddViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import FirebaseAuth

class AddViewController: UIViewController, UITextViewDelegate {
    
    var notifications: [TaskEntityModel] = []
    
    private lazy var nameTaskInput: UITextField = {
        let input = UITextField()
        input.layer.cornerRadius = 12
        input.layer.borderColor = UIColor.systemTeal.cgColor
        input.layer.borderWidth = 2
        input.leftViewMode = .always
        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 16, height: 0))
        input.placeholder = "Заголовок задачи"
        return input
    }()
    
    private let viewInput: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemTeal.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Что нужно сделать?"
        label.textColor = .lightGray
        label.font = UIFont.italicSystemFont(ofSize: 16.0)
        label.isHidden = false
        return label
    }()
    
    private let taskInput: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemTeal.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemTeal.withAlphaComponent(0.5)
        button.addTarget(
            self,
            action: #selector(saveTaskAction),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        makeConstraints()
        title = "Создать задачу"
        
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupLayout() {
        self.view.addSubview(nameTaskInput)
        self.view.addSubview(viewInput)
        viewInput.addSubview(questionLabel)
        viewInput.addSubview(taskInput)
        self.view.addSubview(datePicker)
        self.view.addSubview(saveButton)
        taskInput.delegate = self
    }
    
    func textViewDidChange(_ taskInput: UITextView) {
        if taskInput.hasText == true {
            questionLabel.isHidden = true
        } else {
            questionLabel.isHidden = false
        }
    }
    
    private func makeConstraints() {
        nameTaskInput.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        viewInput.snp.makeConstraints { make in
            make.top.equalTo(nameTaskInput.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(datePicker.snp.top).offset(-20)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        taskInput.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        datePicker.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(saveButton.snp.top).offset(-20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    
    @objc private func saveTaskAction() {
        
        let date = datePicker.date
        
        guard let title = nameTaskInput.text else {
            print("there is no title")
            return
        }
        guard let subTitle = taskInput.text else {
            print("there is no subtitle")
            return
        }
        
        let localPush = LocalPush(
            title: title,
            subtitle: subTitle,
            date: date,
            repeats: false
        )
        
        PushManager.shared.createPushFrom(push: localPush)
        let notification = TaskEntityModel()
        notification.notificationName = title
        notification.notificationText = subTitle
        notification.date = date
        notifications.append(notification)
        RealmManager().write(notification)
        
    }
}

extension AddViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
