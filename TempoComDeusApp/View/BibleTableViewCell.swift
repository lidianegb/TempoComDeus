//
//  BibleTableViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit

class BibleTableViewCell: UITableViewCell {

    var actualVerse: Verse?
    var fontSize: Int!
    var stackView: UIStackView!
   
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
    
    let imageNote: UIImageView = {
        UIImageView(image: UIImage(systemName: "bookmark.fill"))
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

         if selected {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue |
                                        NSUnderlineStyle.single.rawValue,
                                      NSAttributedString.Key.underlineColor: UIColor.blueAct]
                as [NSAttributedString.Key: Any]
            let underlineAttributedString = NSAttributedString(string: verse.text ?? "", attributes: underlineAttribute)
            verse.attributedText = underlineAttributedString
         } else {
            verse.attributedText = NSMutableAttributedString.init(string: verse.text ?? "")
         }
     }
    
    func createCell(actualVerse: Verse) {
        self.actualVerse = actualVerse
        self.backgroundColor = .backViewColor
        self.verse.text = "\(actualVerse.verseNumber + 1).  " + actualVerse.verseText
        fontSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        self.verse.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.selectionStyle = .none
        
        setButtonNoteDimension()
        addStackView()
        addGestures()
        setNote()
        self.verse.backgroundColor = actualVerse.isHighlighted ? .highlighted : .clear
    }
    
    func setNote() {
        if let actualVerse = actualVerse, actualVerse.noteId != nil {
                imageNote.isHidden = false
        } else { imageNote.isHidden = true }
    }
    
    func setButtonNoteDimension() {
        let allConstraints = imageNote.constraints
        for constraint in allConstraints {
            imageNote.removeConstraint(constraint)
        }
        imageNote.setDimensions(width: CGFloat(fontSize), height: CGFloat(fontSize))
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
        verse.attributedText = NSMutableAttributedString.init(string: verse.text ?? "")
        if let actualVerse = actualVerse {
            UserDefaultsPersistence.shared.setVerseHighlighted(verse: actualVerse)
        }
        
    }
    
    func addStackView() {
        stackView = UIStackView(arrangedSubviews: [verse, imageNote])
        stackView.alignment = .leading
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: 8, paddingLeft: 8, paddingRight: 16)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: verse.bottomAnchor, constant: 8).isActive = true
    }
}
