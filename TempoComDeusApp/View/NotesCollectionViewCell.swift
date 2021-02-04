//
//  NotasCollectionViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit
import Foundation

class NotesCollectionViewCell: UICollectionViewCell {

    var onDeleteCell: ((_ cell: NotesCollectionViewCell) -> Void)?
    
    var note: NoteViewModel? {
       didSet {
           if let note = note {
            labelPreview.text = note.text
            wrapperView.backgroundColor = .getColor(number: Int(note.color))
            labelDate.text = note.date.convertToString()
           }
       }
    }
    
    let wrapperView = UIView()
    let labelPreview = UILabel()
    let labelDate = UILabel()
    let buttonDelete = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func createCell() {
        addWrapperView()
        addTextPreview()
        addButtonDelete()
        addTextDate()
        let fontSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        labelPreview.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
    private func addWrapperView() {
        contentView.addSubview(wrapperView)
       
        wrapperView.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 8,
                           paddingBottom: 0,
                           paddingRight: 8)
        wrapperView.layer.masksToBounds = true
        wrapperView.layer.cornerRadius = 8
    }
    
    private func addTextPreview() {
        labelPreview.font = UIFont.systemFont(ofSize: 17)
        labelPreview.textAlignment = .left
        labelPreview.textColor = .label
        labelPreview.numberOfLines = 0
        wrapperView.addSubview(labelPreview)
        labelPreview.anchor(top: wrapperView.topAnchor,
                            left: wrapperView.leftAnchor,
                            right: wrapperView.rightAnchor,
                            paddingTop: 10,
                            paddingLeft: 12,
                            paddingRight: 12)
    }
    
    private func addButtonDelete() {
        buttonDelete.setImage(UIImage(systemName: "trash"), for: .normal)
        buttonDelete.imageView?.tintColor = .secondaryLabel
        buttonDelete.imageView?.contentMode = .scaleAspectFill
        wrapperView.addSubview(buttonDelete)
        buttonDelete.contentVerticalAlignment = .fill
        buttonDelete.contentHorizontalAlignment = .fill
        buttonDelete.anchor( top: labelPreview.bottomAnchor,
                             bottom: wrapperView.bottomAnchor,
                             right: wrapperView.rightAnchor,
                             paddingTop: 10,
                             paddingBottom: 10,
                             paddingRight: 12,
                             width: 20,
                             height: 20)
        buttonDelete.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
    }
    
    private func addTextDate() {
        labelDate.font = UIFont.systemFont(ofSize: 14)
       labelDate.textAlignment = .left
       labelDate.textColor = .secondaryLabel
       labelDate.numberOfLines = 1
       wrapperView.addSubview(labelDate)
        labelDate.anchor(top: labelPreview.bottomAnchor,
                         left: wrapperView.leftAnchor,
                         bottom: wrapperView.bottomAnchor,
                         right: buttonDelete.leftAnchor,
                         paddingTop: 10,
                         paddingLeft: 12,
                         paddingBottom: 10,
                         paddingRight: 12)
    }
    
    @objc func deleteCell() {
        onDeleteCell?(self)
    }
}
