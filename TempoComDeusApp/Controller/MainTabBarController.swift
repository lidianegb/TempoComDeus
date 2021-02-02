//
//  MainTabBarController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureUI()
    }
 
    // MARK: Helpers
        
    func configureUI() {
        tabBar.barTintColor = .backgroundColor
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false
    }
    
    func configureViewControllers() {
        let bible = BibleViewController()
        let navBible = templeteNavigationController(image: UIImage(named: "icon_biblia_unselected"),
                                                     title: "Biblia",
                                                     rootViewController: bible)

        let notes = NotesViewController()
        let navNotes = templeteNavigationController(image: UIImage(named: "icon_nota_unselected"),
                                                    title: "Anotações", rootViewController: notes)
        let config = ConfigViewController()
        let navConfig = templeteNavigationController(image: UIImage(systemName: "gear"),
                                                     title: "Ajustes", rootViewController: config)
        
        viewControllers = [navBible, navNotes, navConfig]
        
    }
    
    func templeteNavigationController(image: UIImage?, title: String,
                                      rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .backgroundColor
        return nav
    }

}
