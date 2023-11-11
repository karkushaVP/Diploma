//
//  AddViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import FirebaseAuth

//enum ControllerMode {
//    case create
//    case edit
//}

class AddViewController: UIViewController {

//    private let mode: ControllerMode
//
//    private lazy var nameTaskInput: UITextField = {
//        let input = UITextField()
//        input.layer.cornerRadius = 12
//        input.layer.borderColor = UIColor.lightGray.cgColor
//        input.layer.borderWidth = 1
//        input.leftViewMode = .always
//        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
//        return input
//    }()
//
//    private lazy var taskInput: UITextField = {
//        let input = UITextField()
//        input.layer.cornerRadius = 12
//        input.layer.borderColor = UIColor.lightGray.cgColor
//        input.layer.borderWidth = 1
//        input.leftViewMode = .always
//        input.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 0))
//        return input
//    }()
//
//    private lazy var saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Сохранить", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.addTarget(
//            self,
//            action: #selector(saveContactAction),
//            for: .touchUpInside
//        )
//        return button
//    }()
//
//    init(mode: ControllerMode) {
//        self.mode = mode
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        setupLayout()
//        makeConstraints()
//        setupControllerMode()
    }
//
//    private func setupLayout() {
//        self.view.addSubview(nameTaskInput)
//        self.view.addSubview(taskInput)
//        self.view.addSubview(saveButton)
//    }
//
//    private func makeConstraints() {
//        nameTaskInput.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
//            make.leading.trailing.equalToSuperview().inset(16)
//        }
//
//        taskInput.snp.makeConstraints { make in
//            make.top.equalTo(nameTaskInput.snp.bottom).inset(-20)
//            make.leading.trailing.equalToSuperview().inset(16)
//        }
//
//        saveButton.snp.makeConstraints { make in
//            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
//            make.leading.trailing.equalToSuperview().inset(16)
//        }
//    }
//
//    private func setupControllerMode() {
//        switch mode {
//        case .create:
//            title = "Создать дело"
//        case .edit(let editable):
//            title = "Изменить дело"
//
//            guard let user = Auth.auth().currentUser,
//                  let taskId = editable.id
//            else { return }
//            Environment.ref.child("users/\(user.uid)/contacts/\(taskId)").observeSingleEvent(of: .value) { [weak self] snapshot,arg  in
//                guard let contactValue = snapshot.value as? [String: Any],
//                      let taskForEdit = try? Task(key: taskId, dict: contactValue)
//                else { return }
//
//                self?.nameTaskInput.text = taskForEdit.name
//                self?.taskInput.text = taskForEdit.task
//            }
//
//            let addButton = UIButton(type: .system)
//            addButton.addTarget(self, action: #selector(deleteContact), for: .touchUpInside)
//            addButton.setImage(UIImage(systemName: "trash"), for: .normal)
//            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
//        }
//    }
//
//    @objc private func deleteContact() {
//        switch mode {
//        case .create:
//            break
//        case .edit(let editable):
//
//            guard let user = Auth.auth().currentUser,
//                  let contactId = editable.id
//            else { return }
//            Environment.ref.child("users/\(user.uid)/contacts/\(contactId)").removeValue()
//            navigationController?.popViewController(animated: true)
//        }
//    }
//
//    @objc private func saveContactAction() {
//        guard let name = nameTaskInput.text,
//              let task = taskInput.text,
//              let user = Auth.auth().currentUser
//        else { return }
//
//        let task = Task(
//            id: nil,
//            name: name,
//            task: task)
//
//        switch mode {
//        case .create:
//            Environment.ref.child("users/\(user.uid)/contacts").childByAutoId().setValue(task.asDict)
//        case .edit(let editable):
//            guard let id = editable.id else { return }
//            Environment.ref.child("users/\(user.uid)/contacts/\(id)").updateChildValues(task.asDict)
//        }
//    }
}
