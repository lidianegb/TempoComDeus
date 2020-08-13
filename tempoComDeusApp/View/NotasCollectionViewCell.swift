//
//  NotasCollectionViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotasCollectionViewCell: UICollectionViewCell {

    let wrapperView = UIView()
    let labelPreview = UILabel()
    let labelDate = UILabel()
    let buttonDelete = UIButton()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func createCell(text:String, date:String){
        labelPreview.text = text
        labelDate.text = date
        
        addWrapperView()
        addTextPreview(text: text)
        addButtonDelete()
        addTextDate(text: date)
        
    }
    
    private func addWrapperView(){
        wrapperView.backgroundColor = .nota4
        contentView.addSubview(wrapperView)
        wrapperView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
        wrapperView.layer.masksToBounds = true
        wrapperView.layer.cornerRadius = 8
    }
    
    private func addTextPreview(text:String){
        labelPreview.font = UIFont.systemFont(ofSize: 17)
        labelPreview.textAlignment = .left
        labelPreview.text = text
        labelPreview.textColor = .black
        labelPreview.numberOfLines = 2
        wrapperView.addSubview(labelPreview)
        labelPreview.anchor(top: wrapperView.topAnchor, left: wrapperView.leftAnchor, right: wrapperView.rightAnchor, paddingTop: 30, paddingLeft: 12, paddingRight: 12)
    }
    
    
    private func addButtonDelete(){
        buttonDelete.setImage(UIImage(named: "delete"), for: .normal)
        buttonDelete.setDimensions(width: 16, height: 17)
        wrapperView.addSubview(buttonDelete)
        buttonDelete.anchor( top: labelPreview.bottomAnchor, bottom: wrapperView.bottomAnchor, right: wrapperView.rightAnchor, paddingTop: 10, paddingBottom: 20, paddingRight: 12)
    }
    
    private func addTextDate(text:String){
        labelDate.font = UIFont.systemFont(ofSize: 14)
       labelDate.textAlignment = .left
       labelDate.text = text
       labelDate.textColor = .systemGray
       labelDate.numberOfLines = 1
       wrapperView.addSubview(labelDate)
        labelDate.anchor(top: labelPreview.bottomAnchor, left: wrapperView.leftAnchor, bottom: wrapperView.bottomAnchor, right: buttonDelete.leftAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 20, paddingRight: 12)
    }
    
}
