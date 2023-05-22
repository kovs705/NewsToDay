//
//  SceneDelegate.swift
//  NewsToDay
//
//  Created by Kovs on 06.05.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let coordinator = Coordinator()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarController(coordinator: coordinator)
        
        window?.makeKeyAndVisible()
    }
}
