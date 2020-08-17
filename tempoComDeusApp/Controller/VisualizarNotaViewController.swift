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
                textView.text = nota.body
                view.reloadInputViews()
            }
        }
    }
    
    let textView: UITextView = {
        let text = UITextView()
        text.allowsEditingTextAttributes = false
        text.isEditable = false
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.showsVerticalScrollIndicator = false
        text.font = UIFont.systemFont(ofSize: 20)
        return text
    }()
    
       // MARK: Lifecycle
       override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
            addBackView()
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

        func addTextView(){
            backView.addSubview(textView)
            textView.anchor(top: backView.topAnchor, left: backView.leftAnchor, bottom: backView.bottomAnchor, right: backView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 20, paddingRight: 16)
            
        }
    
        private func addBackView(){
           view.insertSubview(backView, at: 0)
           backView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0 , paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
       }

    
}

