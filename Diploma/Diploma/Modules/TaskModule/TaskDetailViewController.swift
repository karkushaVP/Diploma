//
//  TaskDetailViewController.swift
//  Diploma
//
//  Created by Polya on 16.11.23.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var selectedNotification: TaskEntityModel?
    
    private let titleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemTeal.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemTeal.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 50
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeLayout()
        makeConstraints()
        self.navigationItem.rightBarButtonItem = deleteButton
        if let selectedNotification = self.selectedNotification {
            set(element: selectedNotification)
        }
    }
    
    private func makeLayout() {
        
        self.view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        self.view.addSubview(descriptionView)
        descriptionView.addSubview(descriptionLabel)
    }
    
    private func makeConstraints() {
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    @objc private func deleteTask() {
        PopupViewController.show(style: .confirm(
            title: "Вы уверены, что хотите удалить?",
            subtitle: "После удаления задача не подлежит восстановлению, вы не сможете просмотреть ее снова."
        )) {
            print("Вызвано подтверждение")
            if let selectedNotification = self.selectedNotification {
                RealmManager<TaskEntityModel>().delete(object: selectedNotification)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func set(element: TaskEntityModel) {
        titleLabel.text = element.notificationName
        descriptionLabel.text = element.notificationText
    }
    
}
