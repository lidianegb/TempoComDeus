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
  
        if UserDefaults.standard.object(forKey: DARK) != nil { } else {
            let isDark = window?.overrideUserInterfaceStyle.rawValue
            if let isDark = isDark, isDark == 0 {
                UserDefaults.standard.set(true, forKey: DARK)
            } else {
                UserDefaults.standard.set(false, forKey: DARK)
            }
        }
        let darkMode = UserDefaults.standard.bool(forKey: DARK)
        if darkMode {
            window?.overrideUserInterfaceStyle = .dark
        } else {
            window?.overrideUserInterfaceStyle = .light
        }
       
    }

}
