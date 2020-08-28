//
//  NotaView.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 25/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotaView: UIView {

   override init(frame: CGRect) {
      super.init(frame: frame)
      configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textView: UITextView = {
        let text = UITextView()
        text.allowsEditingTextAttributes = false
        text.isEditable = false
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.showsVerticalScrollIndicator = false
        text.textColor = .label
        text.font = UIFont.systemFont(ofSize: 20)
        return text
      }()
    
    func configureUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
      
        addTextView()
    }
    
    func addTextView() {
       self.addSubview(textView)
       textView.anchor(top: self.topAnchor,
                       left: self.leftAnchor,
                       bottom: self.bottomAnchor,
                       right: self.rightAnchor,
                       paddingTop: 20,
                       paddingLeft: 16,
                       paddingBottom: 20,
                       paddingRight: 16)
       
   }

}
