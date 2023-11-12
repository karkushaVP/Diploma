//
//  ListsViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import SnapKit

class TasksViewController: UIViewController {
    
//    var lists = [String]()
    var lists = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10"]
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
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
        self.view.backgroundColor = .white
        setupCollection()
        makeLayout()
        makeConstraints()
        title = "Мои задачи"
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .normal)
    }
    
    private func setupCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register( CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self)
        )
    }
    
    private func makeLayout() {
        self.view.addSubview(collection)
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func makeConstraints() {
        
        collection.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
    }
    
    @objc private func deleteTask() {
        //процесс удаления...
        
        PopupViewController.show(style: .confirm(
            title: "Вы уверены, что хотите удалить?",
            subtitle: "После удаления задача не подлежит восстановлению, вы не сможете просмотреть ее снова."
        )) {
            print("Вызвано подтверждение")
        }
    }

}

extension TasksViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.listNameLabel.text = lists[indexPath.item]
        return cell
    }
}

extension TasksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let contact = data[indexPath.row]
        //        if !contact.isChecked {
        //            contact.isChecked.toggle()
        //        } else {
        //            print("Контакт уже был просмотрен")
        //        }
        //        sortData()
        //    }
    }
}
    
extension TasksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}