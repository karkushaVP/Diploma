//
//  AddViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import FirebaseAuth
import Combine

class AddViewController: UIViewController, UITextViewDelegate {
    
    var notifications: [Element] = []
    
    private lazy var nameTaskInput: UITextField = {
        let input = UITextField()
        input.layer.cornerRadius = 12
        input.layer.borderColor = UIColor.systemTeal.cgColor
        input.layer.borderWidth = 2
        input.leftViewMode = .always
        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        input.placeholder = "Заголовок задачи"
        return input
    }()
    
    private let taskInput: UITextView = {
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.text = "Что нужно сделать?"
            textView.textColor = .lightGray // Placeholder color
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.layer.borderWidth = 2
            textView.layer.cornerRadius = 12
            textView.layer.borderColor = UIColor.systemTeal.cgColor
            textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
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
        self.view.addSubview(taskInput)
        self.view.addSubview(datePicker)
        self.view.addSubview(saveButton)
        taskInput.delegate = self
    }
    
    @objc func textViewDidChange(_ taskInput: UITextView) {
        if taskInput.text.isEmpty {
            taskInput.text = "Что нужно сделать?"
            taskInput.textColor = .lightGray
        } else {
            taskInput.textColor = .label
        }
    }
    
    private func makeConstraints() {
        nameTaskInput.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        taskInput.snp.makeConstraints { make in
            make.top.equalTo(nameTaskInput.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(datePicker.snp.top).offset(-20)
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
        
        PushManager().createPushFrom(push: localPush)
        let notification = Element()
        notification.notificationName = title
        notification.notificationText = subTitle
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
