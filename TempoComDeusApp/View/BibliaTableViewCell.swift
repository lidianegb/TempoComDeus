//
//  BibliaTableViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class BibliaTableViewCell: UITableViewCell {

    let number: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    let verso: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func createCell(num: String, verso: String) {
        backgroundColor = .backViewColor
        addNumberVerso()
        addTextVerso()
        self.number.text = num
        self.verso.text = verso
    }
    
    func addNumberVerso() {
        contentView.addSubview(number)
        number.anchor(top: contentView.topAnchor,
                      left: contentView.leftAnchor,
                      paddingTop: 0,
                      paddingLeft: 0,
                      width: 30)
    }
    func addTextVerso() {
        contentView.addSubview(verso)
        verso.anchor(top: number.bottomAnchor,
                     left: number.rightAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 1,
                     paddingLeft: 3,
                     paddingRight: 16)
       translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: verso.bottomAnchor, constant: 5).isActive = true
    }
    
}
