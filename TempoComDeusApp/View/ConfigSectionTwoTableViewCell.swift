//
//  ConfigSectionTwoTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 09/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit

class ConfigSectionTwoTableViewCell: UITableViewCell {
    
    let wrapperView: UIView = {
         let wrapper = UIView()
         wrapper.backgroundColor = .backViewColor
         wrapper.layer.cornerRadius = 8
         wrapper.layer.masksToBounds = true
         return wrapper
     }()
    let minimumValue = 17
    let maximumValue = 28
    var fontSize: Int = UserDefaultsPersistence.shared.getDefaultFontSize() {
        didSet {
            updateFontSize(size: fontSize)
            updateButtonTintColor(size: fontSize)
        }
    }
     
    let labelFontSize: UILabel = {
        let label = UILabel()
        label.text = "Tamanho da Fonte"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    lazy var buttonPlus: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(plus), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var buttonMinus: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(minus), for: .touchUpInside)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc func plus() {
        if fontSize < maximumValue {
            fontSize += 1
        }
    }
    
    @objc func minus() {
        if fontSize > minimumValue {
            fontSize -= 1
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateFontSize(size: Int) {
        UserDefaultsPersistence.shared.updateFontSize(size: size)
        labelFontSize.font = UIFont.systemFont(ofSize: CGFloat(size))
        self.layoutIfNeeded()
    }
    
    func updateButtonTintColor(size: Int) {
        buttonMinus.tintColor = fontSize == minimumValue ? .systemGray3 : .blueAct
        buttonMinus.isEnabled = size == minimumValue ? false : true
        buttonMinus.layer.borderColor = size == minimumValue ?
            UIColor.systemGray3.cgColor : UIColor.blueAct.cgColor
        
        buttonPlus.tintColor = fontSize == maximumValue ? .systemGray3 : .blueAct
        buttonPlus.isEnabled = size == maximumValue ? false : true
        buttonPlus.layer.borderColor = size == maximumValue ?
            UIColor.systemGray3.cgColor : UIColor.blueAct.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .backgroundColor
        setupWrapperView()
        setupButtonPlus()
        setupButtonMinus()
        setupLabelFontSize()
    }
    
    func setupFonteSize() {
        fontSize = UserDefaultsPersistence.shared.getDefaultFontSize()
    }
    
    func setupWrapperView() {
        contentView.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingBottom: 3)
    }
    
    func setupButtonPlus() {
        contentView.addSubview(buttonPlus)
        buttonPlus.translatesAutoresizingMaskIntoConstraints = false
        buttonPlus.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
        buttonPlus.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -16).isActive = true
        buttonPlus.setDimensions(width: 30, height: 30)
    }
    
    func setupButtonMinus() {
        contentView.addSubview(buttonMinus)
        buttonMinus.translatesAutoresizingMaskIntoConstraints = false
        buttonMinus.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
        buttonMinus.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 16).isActive = true
        buttonMinus.setDimensions(width: 30, height: 30)
    }
    
    func setupLabelFontSize() {
        contentView.addSubview(labelFontSize)
        labelFontSize.anchor(top: wrapperView.topAnchor,
                            left: wrapperView.leftAnchor,
                            bottom: wrapperView.bottomAnchor,
                            right: wrapperView.rightAnchor)
    }
}
