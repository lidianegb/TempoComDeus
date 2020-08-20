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
        imageView.image = UIImage(named: "delete")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(){
    //    self.backgroundColor = .blue
        
        contentView.addSubview(rightDetail)
//        imageView?.setDimensions(width: 10, height: 10)
        rightDetail.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingRight: 10, width: 10, height: 10)
       // rightDetail.centerY(inView: contentView, rightAnchor: contentView.rightAnchor, paddingRight: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
