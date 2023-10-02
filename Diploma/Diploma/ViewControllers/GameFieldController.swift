//
//  GameField.swift
//  Diploma
//
//  Created by Polya on 25.09.23.
//

import UIKit

class GameFieldController: UIViewController {
    
    var ball = UIView()
    var timer: Timer?
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    private lazy var scene: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemCyan.cgColor
        view.backgroundColor = .systemMint.withAlphaComponent(15)
        view.layer.borderWidth = 2
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createBall()
        makeUI()
        makeConstraints()
        title = "Игровое поле"
    }
    
    @IBAction func settingsOfGame(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let addVC = storyboard.instantiateViewController(withIdentifier: String(describing: SettingsController.self)) as? SettingsController else { return }
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func createBall() {
        self.ball = UIView(frame: CGRect(x: 30, y: 70, width: 70, height: 70))
        ball.layer.borderWidth = 1
        ball.layer.borderColor = UIColor.red.cgColor
        ball.layer.cornerRadius = 35
        ball.backgroundColor = .systemMint
        self.view.addSubview(ball)
    }
    
//    private func createApple() {
//            let padding: UInt32 = 15
//            let randX = CGFloat(arc4random_uniform(UInt32(gameFrameRect.maxX) - padding) + padding)
//            let randY = CGFloat(arc4random_uniform(UInt32(gameFrameRect.maxY) - padding) + padding)
//            let apple = Apple(at: CGPoint(x: randX, y: randY).relative(to: gameFrameRect))
//            gameFrameView.addChild(apple)
//        }
    
    func makeUI() {
        self.view.addSubview(scene)
     }
    
    func makeConstraints() {
        scene.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(30)
            make.size.height.equalTo(150)
        }
     }
}
