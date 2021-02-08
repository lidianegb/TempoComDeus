//
//  BibleTableViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit

class BibleTableViewCell: UITableViewCell {
    
    var actualVerse: Verse?
    
    let number: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    let verse: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func createCell(actualVerse: Verse) {
        self.actualVerse = actualVerse
        backgroundColor = .backViewColor
        self.verse.text = "\(actualVerse.verseNumber + 1).  " + actualVerse.verseText
        let fontSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        self.verse.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.selectionStyle = .none
        addTextVerso()
        addGestures()
    
        self.verse.backgroundColor = actualVerse.isHighlighted ? .highlighted : .clear
    }
    
    func addGestures() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc func doubleTap() {
        let isHighlighted = self.verse.backgroundColor == .highlighted ? true : false
        self.verse.backgroundColor = isHighlighted ? .clear : .highlighted
        actualVerse?.setHighlighted(isHighlighted: !isHighlighted)
        if let actualVerse = actualVerse {
            UserDefaultsPersistence.shared.setVerseHighlighted(verse: actualVerse)
        }
        
    }
    
    func addNumberVerso() {
        contentView.addSubview(number)
        number.anchor(top: contentView.topAnchor,
                      left: contentView.leftAnchor,
                      paddingTop: 0,
                      paddingLeft: 16)
    }
    func addTextVerso() {
        contentView.addSubview(verse)
        verse.anchor(top: contentView.topAnchor,
                     left: contentView.leftAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 8,
                     paddingLeft: 8,
                     paddingRight: 16)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: verse.bottomAnchor, constant: 8).isActive = true
    }
}
