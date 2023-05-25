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
        window = UIWindow(windowScene: windowScene)
        let builder = Builder()
        let switcher = Switch(builder: builder, window: window)
        switcher.root()
        window?.makeKeyAndVisible()
    }
}
