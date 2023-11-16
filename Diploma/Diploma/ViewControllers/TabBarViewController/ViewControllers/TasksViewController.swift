//
//  ListsViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import SnapKit
import Combine

class TasksViewController: UIViewController {

    var notifications: [Element] = []
    
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
        notifications = RealmManager<Element>().read()
        collection.reloadData()
    }
    
    private func setupCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register( CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self)
        )
    }
    
    private func makeLayout() {
        self.view.addSubview(collection)
    }
    
    private func makeConstraints() {
        
        collection.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
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
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}


