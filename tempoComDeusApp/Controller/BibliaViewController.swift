//
//  BibliaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class BibliaViewController: UIViewController {

    // MARK: Properties
  
       
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addBackground()
    
    }
    
    // MARK: Selectors
     
     
     // MARK: Helpers
    
    func configureUI(){
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationItem.title = "biblia"
    }
    
    func addBackground(){
        let backView = BackView()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + (navigationController?.navigationBar.frame.height ?? 0)
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
        view.addSubview(backView)
        backView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: statusBarHeight, paddingLeft: 8, paddingBottom: tabBarHeight, paddingRight: 8)
    }
    

}
