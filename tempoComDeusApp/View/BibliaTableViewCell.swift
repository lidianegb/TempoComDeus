//
//  BibliaTableViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class BibliaTableViewCell: UITableViewCell {

    let num: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    let verso: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func createCell(num: String, verso: String) {
        setupNum()
      setupVerso()
        self.num.text = num
        self.verso.text = verso
        
    }
    
    func setupNum() {
        contentView.addSubview(num)
        num.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 5, paddingLeft: 5, width: 30)
    }
    func setupVerso() {
        contentView.addSubview(verso)
        verso.anchor(top: num.bottomAnchor,
                     left: num.rightAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 1,
                     paddingLeft: 3,
                     paddingRight: 16)
       translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: verso.bottomAnchor, constant: 5).isActive = true
    }
    
}
