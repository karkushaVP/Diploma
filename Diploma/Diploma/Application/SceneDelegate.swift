//
//  SceneDelegate.swift
//  Diploma
//
//  Created by Polya on 13.09.23.
//

import UIKit
import FirebaseAuth

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var pushManager = PushManager.shared


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        pushManager.checkPermission()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        if let loggedUser = Auth.auth().currentUser?.uid {
            window?.rootViewController = TabBarViewController(currentUserId: loggedUser)
        } else {
            window?.rootViewController = UINavigationController(rootViewController: RegistrationViewController())
        }
        window?.makeKeyAndVisible()
    }

}
