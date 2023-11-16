//
//  TaskDetailViewController.swift
//  Diploma
//
//  Created by Polya on 16.11.23.
//

import UIKit
import SnapKit
import Combine

class TaskDetailViewController: UIViewController {
    
    var selectedNotification: Element?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.layer.cornerRadius = 12
        label.layer.borderColor = UIColor.systemTeal.cgColor
        label.layer.borderWidth = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 100
        label.layer.cornerRadius = 12
        label.layer.borderColor = UIColor.systemTeal.cgColor
        label.layer.borderWidth = 2
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
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
    }
    
    private func makeConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    @objc private func deleteTask() {
        PopupViewController.show(style: .confirm(
            title: "Вы уверены, что хотите удалить?",
            subtitle: "После удаления задача не подлежит восстановлению, вы не сможете просмотреть ее снова."
        )) {
            print("Вызвано подтверждение")
            if let selectedNotification = self.selectedNotification {
                RealmManager<Element>().delete(object: selectedNotification)
            }
            UIApplication.shared.keyWindow?.rootViewController = TasksViewController()
        }
    }
    
    func set(element: Element) {
        titleLabel.text = element.notificationName
        descriptionLabel.text = element.notificationText
    }
}
