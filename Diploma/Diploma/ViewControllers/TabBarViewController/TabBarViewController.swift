//
//  TabBarViewController.swift
//  Diploma
//
//  Created by Polya on 1.11.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
    }

    func setupControllers() {
        var controllers: [UIViewController] = []
        
        let profileVC = ProfileViewController()
        controllers.append(UINavigationController(rootViewController: profileVC))
        profileVC.tabBarItem = .init(title: "Image", image: .init(systemName: "person"), tag: 0)
        
        let addVC = AddViewController()
        controllers.append(UINavigationController(rootViewController: addVC))
        addVC.tabBarItem = .init(title: "Image", image: .init(systemName: "plus"), tag: 0)
        
        let calendarVC = CalendarViewController()
        controllers.append(UINavigationController(rootViewController: calendarVC))
        calendarVC.tabBarItem = .init(title: "Image", image: .init(systemName: "calendar"), tag: 0)
        
        let listsVC = ListsViewController()
        controllers.append(UINavigationController(rootViewController: listsVC))
        listsVC.tabBarItem = .init(title: "Image", image: .init(systemName: "pencil"), tag: 0)

        self.viewControllers = controllers
    }
}

