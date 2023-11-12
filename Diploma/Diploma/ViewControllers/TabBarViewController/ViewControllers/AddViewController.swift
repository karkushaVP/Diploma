//
//  AddViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import FirebaseAuth

class AddViewController: UIViewController, UITextViewDelegate {
    
    var lists = [ListModel]()
    
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
    
    private lazy var taskInput: UITextField = {
        let input = UITextField()
        input.layer.cornerRadius = 12
        input.layer.borderColor = UIColor.systemTeal.cgColor
        input.layer.borderWidth = 2
        input.leftViewMode = .always
        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
        input.placeholder = "Что нужно сделать?"
        return input
    }()
    
//    private lazy var taskInput: UITextView = {
//        let input = UITextView()
//        input.layer.cornerRadius = 12
//        input.layer.borderColor = UIColor.systemTeal.cgColor
//        input.layer.borderWidth = 2
//        input.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5) // Adjusting text inset
//        input.textContainer.lineFragmentPadding = 5 // Padding for text
//        input.text = "Что нужно сделать?"
//        input.textColor = .black// Placeholder color
//        return input
//    }()
    
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
        
        //        ТАСК: открыть по нажатию на кнопку с поп ап контроллером и выбрать в какой лист добавить данную задачу или создать новый лист и сохранить это в файер бейз
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        makeConstraints()
        title = "Создать задачу"
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .normal)
        
        //        setupControllerMode()
    }
    
    private func setupLayout() {
        self.view.addSubview(nameTaskInput)
        self.view.addSubview(taskInput)
        self.view.addSubview(saveButton)
        taskInput.delegate = self
    }
    
    @objc func textViewDidChange(_ taskInput: UITextView) {
        if taskInput.text.isEmpty {
            taskInput.text = "Что нужно сделать?"
            taskInput.textColor = .lightGray
        } else {
            taskInput.textColor = .label // Or any color for user input
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
            make.height.equalTo(170)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    
    @objc private func saveTaskAction() {
        guard let name = nameTaskInput.text,
              let task = taskInput.text,
              let user = Auth.auth().currentUser
        else { return }
        
//        let task = Task(
//            id: nil,
//            name: name,
//            task: task)
//        
//        Environment.ref.child("users/\(user.uid)/contacts/\(id)/tasks/\(id)").childByAutoId().setValue(task.asDict)
    }
}
