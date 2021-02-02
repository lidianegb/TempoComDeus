//
//  ChaptersCollectionViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 20/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class ChaptersCollectionViewCell: UICollectionViewCell {
    
    let labelCapitulo: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func awakeFromNib() {
          super.awakeFromNib()
          
      }
      
    func createCell(textLabel: String) {
        self.backgroundColor = .backViewColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.blueAct.cgColor
        self.layer.borderWidth = 0.5
        
        addLabel(textLabel: textLabel)
          
      }
    
    func addLabel(textLabel: String) {
        labelCapitulo.text = textLabel
        contentView.addSubview(labelCapitulo)
        labelCapitulo.center(inView: contentView)
      
    }
}
