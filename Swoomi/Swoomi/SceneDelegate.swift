//
//  SceneDelegate.swift
//  Swoomi
//
//  Created by 권성은 on 2021/11/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
//        window?.rootViewController = MainViewController()
//        window?.rootViewController = ChampCollectionViewController()
//        window?.tintColor = .label
        window?.makeKeyAndVisible()
    }

}

