//
//  CollectionViewCell.swift
//  Diploma
//
//  Created by Polya on 11.11.23.
//

import UIKit
import SnapKit
import Combine

final class CollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: CollectionViewCell.self)
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Task"
        label.numberOfLines = 3
        label.textColor = .systemTeal
        label.font = UIFont.italicSystemFont(ofSize: 25.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
        makeConstraints()
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        contentView.addSubview(taskNameLabel)
    }
    
    private func makeConstraints() {
        
        taskNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func set(element: TaskEntityModel) {
        taskNameLabel.text = element.notificationName
    }
    
    func setupCell() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor.init(red: 0.3529, green: 0.7843, blue: 0.9804, alpha: 0.5)
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .systemTeal.withAlphaComponent(0.3)
    }
}

