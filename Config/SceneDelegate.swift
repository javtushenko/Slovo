//
//  SceneDelegate.swift
//  Slovo
//
//  Created by Николай Явтушенко on 19.06.2022.
//

import UIKit

public var baseViewController: UIViewController?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // тут стартовый экран задаем если шо
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        baseViewController = window?.rootViewController
        window?.rootViewController = MainGameModuleConfigurator.build()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
