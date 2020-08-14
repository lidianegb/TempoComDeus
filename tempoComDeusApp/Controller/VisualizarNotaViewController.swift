//
//  VisualizarNotaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 14/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class VisualizarNotaViewController: UIViewController {

    // MARK: Properties
     let backView = BackView()
    
    var nota: Nota?{
        didSet{
            if let nota = nota{
                backView.backgroundColor = UIColor.getColor(name: nota.color)
                textView.text = nota.text
                view.reloadInputViews()
                
            }
        }
    }
          
    let textView: UITextView = {
        let text = UITextView()
        text.allowsEditingTextAttributes = false
        text.isEditable = false
        text.backgroundColor = .clear
        text.showsVerticalScrollIndicator = false
        text.font = UIFont.systemFont(ofSize: 20)
        return text
    }()
    
       // MARK: Lifecycle
       override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
            addBackground()
            addTextView()
       
       }
       
       // MARK: Selectors
        
        
        // MARK: Helpers
       
       func configureUI(){
           navigationController?.navigationBar.shadowImage = UIImage()
           view.backgroundColor = .blueBackgroud
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
            backView.layer.cornerRadius = 10
            backView.layer.masksToBounds = true
       }
    
       func addBackground(){
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let statusBarHeight = (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + (navigationController?.navigationBar.frame.height ?? 0 )
            let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
            view.insertSubview(backView, at: 0)
            backView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: statusBarHeight, paddingLeft: 8, paddingBottom: tabBarHeight, paddingRight: 8)
    }

    func addTextView(){
        backView.addSubview(textView)
        textView.anchor(top: backView.topAnchor, left: backView.leftAnchor, bottom: backView.bottomAnchor, right: backView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 20, paddingRight: 16)
        
    }
}
    

