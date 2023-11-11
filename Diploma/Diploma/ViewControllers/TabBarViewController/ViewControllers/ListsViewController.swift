//
//  ListsViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit
import SnapKit

class ListsViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupCollection()
        makeLayout()
        makeConstraints()
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

extension ListsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.listNameLabel.text = lists[indexPath.item]
        return cell
    }
}

extension ListsViewController: UICollectionViewDelegate {
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
    
extension ListsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}
