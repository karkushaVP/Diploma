//
//  ListsViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit

final class TasksViewController: UIViewController {

    var notifications: [TaskEntityModel] = []
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "На данный момент список задач пуст"
        label.textColor = .systemGray3
        label.numberOfLines = 2
        label.font = UIFont.italicSystemFont(ofSize: 25.0)
        label.isHidden = false
        return label
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupCollection()
        makeLayout()
        makeConstraints()
        title = "Мои задачи"
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notifications = RealmManager<TaskEntityModel>().read().reversed()
        
        if notifications.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
        
        collection.reloadData()
    }
    
    private func setupCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register( CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self)
        )
    }
    
    func deleteCollectionData() {
        notifications.removeAll()
        collection.reloadData()
    }
    
    private func makeLayout() {
    
        self.view.addSubview(collection)
        self.view.addSubview(emptyLabel)
    }
    
    private func makeConstraints() {
        
        collection.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension TasksViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.set(element: notifications[indexPath.row])
        return cell
    }
}

extension TasksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let taskDetailVC = TaskDetailViewController()
        taskDetailVC.selectedNotification = notifications[indexPath.row]
        self.navigationController?.pushViewController(taskDetailVC, animated: true)
    }
}
    
extension TasksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        let cellWidth = collectionViewSize / 2 - 4
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
