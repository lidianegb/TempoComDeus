//
//  SectionLivrosTableViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 19/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class SectionLivrosTableViewCell: UITableViewCell {
    
    var rightDetail: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrowdown")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    func configure() {
   
        contentView.addSubview(rightDetail)
        rightDetail.setDimensions(width: 14, height: 14)
        rightDetail.centerY(inView: contentView, rightAnchor: contentView.rightAnchor, paddingRight: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
extension SectionLivrosTableViewCell {
    func didSelected(isSelected: Bool) {
        if isSelected {
            rightDetail.image = UIImage(named: "arrowup")
            textLabel?.textColor = .blueAct } else {
             rightDetail.image = UIImage(named: "arrowdown")
             textLabel?.textColor = .black
        }
        self.reloadInputViews()
    }
    
}
