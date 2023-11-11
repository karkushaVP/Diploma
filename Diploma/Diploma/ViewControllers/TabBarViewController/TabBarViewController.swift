//
//  TabBarViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let currentUserId: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupControllers() {
        var controllers: [UIViewController] = []
        
        let profileVC = ProfileViewController(mode: .read(currentUserId))
        controllers.append(UINavigationController(rootViewController: profileVC))
        profileVC.tabBarItem = .init(title: "Профиль", image: .init(systemName: "person"), tag: 0)
        
        let addVC = AddViewController()
        controllers.append(UINavigationController(rootViewController: addVC))
        addVC.tabBarItem = .init(title: "Добавить", image: .init(systemName: "plus"), tag: 0)
        
        let calendarVC = CalendarViewController()
        controllers.append(UINavigationController(rootViewController: calendarVC))
        calendarVC.tabBarItem = .init(title: "Календарь", image: .init(systemName: "calendar"), tag: 0)
        
        let listsVC = ListsViewController()
        controllers.append(UINavigationController(rootViewController: listsVC))
        listsVC.tabBarItem = .init(title: "Списки", image: .init(systemName: "pencil"), tag: 0)

        self.viewControllers = controllers
    }
}

