//
//  FlexibleView.swift
//  Diploma
//
//  Created by Polya on 2.10.23.
//

import UIKit
import SnapKit


protocol FlexibleViewDelegate: AnyObject {
    func viewWillOpen(_ flexibleView: UIView)
}

protocol Expandable {
    func forceClose()
}

class FlexibleView<T: UIView>: UIView {
    var insertedView = T()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.cornerRadius = 12
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 1
        stack.spacing = 10
        stack.clipsToBounds = true
        return stack
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Тестовый текст"
        return label
    }()
    
    lazy var buttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        return imageView
    }()

    weak var delegate: FlexibleViewDelegate?
    
    private(set) var isOpen = false
    
    public var topColor: UIColor = .purple.withAlphaComponent(0.1)
    
    init(
        text: String,
        rightImage: UIImage? = nil,
        topColor: UIColor? = nil
    ) {
        super.init(frame: .zero)
        commonInit()
        
        self.titleLabel.text = text
        if let topColor {
            self.topColor = topColor
        }

        if let rightImage {
            self.buttonImage.image = rightImage
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        makeLayout()
        makeConstraints()
        makeGestures()
        insertedView.isHidden = true
    }
    
    private func makeLayout() {
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(topView)
        topView.addSubview(titleLabel)
        topView.addSubview(buttonImage)
        mainStack.addArrangedSubview(insertedView)
    }
    
    private func makeConstraints() {
        mainStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
        }
        
        topView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        buttonImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func makeGestures() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction)
        )
        topView.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction() {
        if !isOpen {
            delegate?.viewWillOpen(self)
        }
        self.isOpen = !isOpen
        topView.backgroundColor = isOpen ? topColor : .white
        UIView.animate(withDuration: 0.4, delay: 0, options: .layoutSubviews) { [weak self] in
            guard let self else { return }
            insertedView.isHidden = !isOpen
            buttonImage.transform = CGAffineTransform(rotationAngle: !isOpen ? 0 : .pi)
        }
    }
}

extension FlexibleView: Expandable {
    func forceClose() {
        if isOpen {
            tapAction()
        }
    }
}
