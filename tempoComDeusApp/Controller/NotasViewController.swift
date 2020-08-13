//
//  NotasViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotasViewController: UIViewController {

    // MARK: Properties
    let initialLabel: UILabel = {
        var label = UILabel()
        label.text = "Clique + para adicionar uma nova anotação."
        label.textColor = .myGray
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
     let backView = BackView()
         
      // MARK: Lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addBackground()
        addTextInicial()
          // Do any additional setup after loading the view.
      }
      
      // MARK: Selectors
       
       
       // MARK: Helpers
      
      func configureUI(){
    
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blueBackgroud
        navigationController?.navigationBar.isHidden = true
      
    }
    
    func addTextInicial(){
        backView.addSubview(initialLabel)
        initialLabel.anchor(left: backView.leftAnchor, right: backView.rightAnchor,paddingLeft: 16, paddingRight: 16)
        initialLabel.centerY(inView: backView)
    }
    
    func addBackground(){
         
          let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
          let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
          let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
          view.addSubview(backView)
          backView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: statusBarHeight, paddingLeft: 8, paddingBottom: tabBarHeight, paddingRight: 8)
      }


}
