//
//  BibleTableViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class BibleTableViewCell: UITableViewCell {
    
    let number: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
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
        self.verso.text = num + ".  " + verso
        let fontSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        self.verso.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        addTextVerso()
    }
    
    func addNumberVerso() {
        contentView.addSubview(number)
        number.anchor(top: contentView.topAnchor,
                      left: contentView.leftAnchor,
                      paddingTop: 0,
                      paddingLeft: 16)
    }
    func addTextVerso() {
        contentView.addSubview(verso)
        verso.anchor(top: contentView.topAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 8,
                     paddingLeft: 8,
                     paddingRight: 16)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: verso.bottomAnchor, constant: 8).isActive = true
    }
}
