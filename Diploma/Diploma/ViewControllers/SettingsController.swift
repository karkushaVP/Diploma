//
//  settingsController.swift
//  Diploma
//
//  Created by Polya on 2.10.23.
//

import UIKit
import SnapKit

class SettingsController: UIViewController, FlexibleViewDelegate {
    
    private lazy var flexibleView = FlexibleView<UILabel>(text: "Выбери тему", topColor: .systemMint)
    
    private lazy var changeSegment: UISegmentedControl = {
        var segment = UISegmentedControl()
        segment = UISegmentedControl(items: ["Цветная", "Ч/Б"])
        segment.selectedSegmentIndex = 0
        segment.selectedSegmentTintColor = .systemMint
        return segment
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "проверка движения лейбла при открытии стека"
        return label
    }()
    
    private lazy var secondFlexibleView = FlexibleView<UIView>(text: "Тут зелёная вьюха")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        flexibleView.delegate = self
        secondFlexibleView.delegate = self
        title = "Настройки"
    }
    
    private func makeLayout() {
        self.view.addSubview(flexibleView)
        
        flexibleView.addSubview(changeSegment)
        //        flexibleView.insertedView.text = "Тестовый встроеный лейбл, будет находиться внутри флексибел вью и будет распологаться в стеке."
        //        flexibleView.insertedView.numberOfLines = 0
        //        flexibleView.insertedView.textColor = .red
        //        flexibleView.insertedView.font = .systemFont(ofSize: 20)
        //        flexibleView.insertedView.backgroundColor = .white
        
        self.view.addSubview(secondFlexibleView)
        secondFlexibleView.insertedView.backgroundColor = .green
        secondFlexibleView.insertedView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        //        строка снизу заменяет настройку элемента и можно установить внутрь нашего расширяющегося вью любой УЖЕ ГОТОВЫЙ элемент без его кода настройки
        //        secondFlexibleView.insertedView = UIView()
        
        self.view.addSubview(textLabel)
    }
    
    private func makeConstraints() {
        flexibleView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(flexibleView.snp.bottom).inset(-20)
        }
        
        secondFlexibleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textLabel.snp.bottom).inset(-20)
            
        }
    }
    
    func viewWillOpen(_ flexibleView: UIView) {
        let closable = self.view.subviews.filter({ $0 is Expandable && $0 != flexibleView }) as? [Expandable]
        closable?.forEach({ $0.forceClose() })
    }
}

//extension SettingsController: FlexibleViewDelegate {
//    func viewWillOpen(_ flexibleView: UIView) {
////        switch flexibleView {
////        case self.flexibleView:
////            secondFlexibleView.forceClose()
////        case self.secondFlexibleView:
////            self.flexibleView.forceClose()
////        default:
////            break
////        }
//
//        let closable = self.view.subviews.filter({ $0 is Expandable && $0 != flexibleView }) as? [Expandable]
//        closable?.forEach({ $0.forceClose() })
//    }
//}
