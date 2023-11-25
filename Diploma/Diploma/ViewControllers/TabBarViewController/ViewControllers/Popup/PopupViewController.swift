//
//  PopupViewController.swift
//  Diploma
//
//  Created by Polya on 12.11.23.
//

import UIKit
import SnapKit

typealias VoidBlock = () -> Void

class PopupViewController: UIViewController {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заголовок"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Подзаголовок"
        label.textAlignment = .center
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(
            self,
            action: #selector(close),
            for: .touchUpInside
        )
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.addTarget(
            self,
            action: #selector(accept),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var buttonContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    private var acceptAction: VoidBlock?
    
    init(style: Style, acceptAction: VoidBlock? = nil) {
        super.init(nibName: nil, bundle: nil)
        makeStyle(style)
        self.acceptAction = acceptAction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        makeGestures()
    }
    
    private func makeLayout() {
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.addSubview(mainView)
        mainView.addSubview(contentStack)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(subTitleLabel)
        contentStack.addArrangedSubview(buttonContainer)
        
        buttonContainer.addArrangedSubview(acceptButton)
        buttonContainer.addArrangedSubview(cancelButton)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
    
    private func makeGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        self.view.addGestureRecognizer(tap)
    }
    
    private func makeStyle(_ style: Style) {
        makeColorsFor(style)
        makeTextFor(style)
        makeLayoutFor(style)
    }
    
    private func makeColorsFor(_ style: Style) {
        switch style {
            case .confirm:
                self.acceptButton.backgroundColor = .red.withAlphaComponent(0.8)
            case .logout:
            self .acceptButton.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        }
    }
    
    private func makeTextFor(_ style: Style) {
        switch style {
            case .confirm(let title, let subtitle):
                self.acceptButton.setTitle("Удалить", for: .normal)
                self.cancelButton.setTitle("Отмена", for: .normal)
                self.titleLabel.text = title
                self.subTitleLabel.text = subtitle
            case .logout(let title, let subtitle):
                self.acceptButton.setTitle("Подтвердить", for: .normal)
                self.cancelButton.setTitle("Отмена", for: .normal)
                self.titleLabel.text = title
                self.subTitleLabel.text = subtitle
        }
    }
    
    private func makeLayoutFor(_ style: Style) {
        switch style {
            case .confirm:
                break
            case .logout:
                break
        }
    }
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
    
    @objc private func accept() {
        self.dismiss(animated: true)
        self.acceptAction?()
    }
}

extension PopupViewController {
    enum Style {
        case confirm(title: String, subtitle: String? = nil)
        case logout(title: String, subtitle: String? = nil)
    }
}

extension PopupViewController {
    static func show(style: Style, acceptAction: VoidBlock? = nil) {
        let popup = PopupViewController(style: style, acceptAction: acceptAction)
        
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(popup, animated: true)
        }
    }
}

