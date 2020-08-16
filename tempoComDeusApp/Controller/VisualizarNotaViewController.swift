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
           
        let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
        let top = (window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0) + (navigationController?.navigationBar.frame.size.height ?? 0)
        let bottom = tabBarController?.tabBar.frame.size.height ?? 0
    
           view.insertSubview(backView, at: 0)
           backView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: top , paddingLeft: 8, paddingBottom: bottom, paddingRight: 8)
        
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

    
}
    

extension UIViewController{
    
    
    /// Calculate top distance with "navigationBar" and "statusBar" by adding a
    /// subview constraint to navigationBar or to topAnchor or superview
    /// - Returns: The real distance between topViewController and Bottom navigationBar
    func calculateTopDistance() -> CGFloat{
        
        /// Create view for misure
        let misureView : UIView     = UIView()
        misureView.backgroundColor  = .clear
        view.addSubview(misureView)
        
        /// Add needed constraint
        misureView.translatesAutoresizingMaskIntoConstraints                    = false
        misureView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive     = true
        misureView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive   = true
        misureView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        if let nav = navigationController {
            misureView.topAnchor.constraint(equalTo: nav.navigationBar.bottomAnchor).isActive = true
        }else{
            misureView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        /// Force layout
        view.layoutIfNeeded()
        
        /// Calculate distance
        let distance = view.frame.size.height - misureView.frame.size.height
        
        /// Remove from superview
        misureView.removeFromSuperview()
        
        return distance
        
    }
    
}
