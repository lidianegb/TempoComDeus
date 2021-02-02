//
//  VersicleTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 17/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class VersicleTableViewCell: UITableViewCell {
    let backView = BackView()
    weak var delegate: NewNotaDelegate?
    
    var versoLabel: UILabel = {
        let text = UILabel()
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 20)
        text.textColor = .label
        text.layer.cornerRadius = 5
        text.clipsToBounds = true
        return text
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createCell() {
        addBackView()
        addTextField()
    }
    
    private func addBackView() {
        backView.backgroundColor = .getColor(name: "nota1")
        contentView.insertSubview(backView, at: 0)

        backView.anchor(top: contentView.topAnchor,
                        left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 8,
                        paddingBottom: 0,
                        paddingRight: 8)
    }
    
    func addTextField() {
        backView.addSubview(versoLabel)
        versoLabel.anchor(top: backView.topAnchor,
                       left: backView.leftAnchor,
                       bottom: backView.bottomAnchor,
                       right: backView.rightAnchor,
                       paddingTop: 8,
                       paddingLeft: 16,
                       paddingBottom: 8,
                       paddingRight: 16)
    }

}
