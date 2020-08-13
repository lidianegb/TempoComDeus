//
//  MainTabBarController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: Properties
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: Selectors
    
    
    // MARK: Helpers
    
    func configureViewControllers(){
        let biblia = BibliaViewController()
        let navBiblia = templetaNavigationController(image: UIImage(named: "icon_biblia_unselected"), rootViewController: biblia)

        let notas = NotasViewController()
        let navNotas = templetaNavigationController(image: UIImage(named: "icon_nota_unselected"), rootViewController: notas)

        viewControllers = [navBiblia, navNotas]
        
    }
    
    func templetaNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    

}
