//
//  ViewController.swift
//  Diploma
//
//  Created by Polya on 13.09.23.
//

import UIKit
import SnapKit

class WelcomeController: UIViewController {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemCyan.cgColor
        view.backgroundColor = .systemMint
        view.layer.borderWidth = 4
        return view
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет!"
        label.textColor = .black
        label.textAlignment = .center
        label.shadowColor = .gray
        label.font = UIFont.italicSystemFont(ofSize: 26.0)
        return label
    }()
    
    private lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери тему, что тебе нравится. Позже ты сможешь изменить ее в настройках."
        label.textColor = .black
        label.textAlignment = .center
        label.shadowColor = .gray
        label.font = UIFont.italicSystemFont(ofSize: 15.0)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var changeSegment: UISegmentedControl = {
        var segment = UISegmentedControl()
        segment = UISegmentedControl(items: ["Цветная", "Ч/Б"])
        segment.selectedSegmentIndex = 0
        segment.selectedSegmentTintColor = .systemMint
        return segment
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать игру!", for: UIControl.State.normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.systemCyan.cgColor
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action:#selector(startGame), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeConstraints()
        view.backgroundColor = .systemYellow
    }
    
    func makeUI() {
        self.view.addSubview(mainView)
        self.view.addSubview(changeLabel)
        self.view.addSubview(changeSegment)
        mainView.addSubview(mainLabel)
        self.view.addSubview(doneButton)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(30)
            make.size.height.equalTo(150)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).inset(-130)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        changeSegment.snp.makeConstraints { make in
            make.top.equalTo(changeLabel).inset(70)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
    }
    
    @objc func startGame(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let addVC = storyboard.instantiateViewController(withIdentifier: String(describing: GameFieldController.self)) as? GameFieldController else { return }
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}
