//
//  SceneDelegate.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController =  MainTabBarController()
        window?.tintColor = .blueAct
        window?.makeKeyAndVisible()
        UserDefaultsPersistence.shared.setDefaultKeyTheme()
        let darkMode = UserDefaultsPersistence.shared.getKeyTheme()
        print(darkMode)
        if darkMode == 1 {
            window?.overrideUserInterfaceStyle = .light
        } else if darkMode == 2 {
            window?.overrideUserInterfaceStyle = .dark
        }
       
    }

}
