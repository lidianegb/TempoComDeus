//
//  ConfigSectionOneTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 09/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class ConfigSectionOneTableViewCell: UITableViewCell {
    
    let defaults = UserDefaults.standard
    
    let darkMode = UserDefaults.standard.bool(forKey: DARK)
    
    let wrapperView: UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = .backViewColor
        wrapper.layer.cornerRadius = 8
        wrapper.layer.masksToBounds = true
        return wrapper
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Tema:"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    lazy var buttonLight: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 30, height: 30)
        if darkMode {
            button.tintColor = .systemGray3
        } else {
            button.tintColor = .blueAct
        }
        button.setBackgroundImage(UIImage(systemName: "sun.max.fill"), for: .normal)
        button.addTarget(self, action: #selector(setLightMode), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonDark: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 30, height: 30)
        if darkMode {
            button.tintColor = .blueAct
        } else {
            button.tintColor = .systemGray3
        }
         button.setBackgroundImage(UIImage(systemName: "moon.fill"), for: .normal)
        button.addTarget(self, action: #selector(setDarkMode), for: .touchUpInside)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .backgroundColor
        setupWrapperView()
        setupLabel()
        setupButtons()
    }
    
    @objc func setDarkMode() {
        window?.overrideUserInterfaceStyle = .dark
        defaults.set(true, forKey: DARK)
        buttonLight.tintColor = .systemGray3
        buttonDark.tintColor = .blueAct
        self.layoutIfNeeded()
    }
    
    @objc func setLightMode() {
        window?.overrideUserInterfaceStyle = .light
        defaults.set(false, forKey: DARK)
        buttonLight.tintColor = .blueAct
        buttonDark.tintColor = .systemGray3
        self.layoutIfNeeded()
    }
    
    func setupWrapperView() {
        contentView.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 0, paddingLeft: 0,
                           paddingBottom: 3, paddingRight: 0)
    }
    
    func setupLabel() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 8).isActive = true
    }
    
    func setupButtons() {
        contentView.addSubview(buttonDark)
        buttonDark.translatesAutoresizingMaskIntoConstraints = false
        buttonDark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        buttonDark.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -8).isActive = true
        
        contentView.addSubview(buttonLight)
        buttonLight.translatesAutoresizingMaskIntoConstraints = false
        buttonLight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        buttonLight.rightAnchor.constraint(equalTo: buttonDark.leftAnchor, constant: -8).isActive = true
    }
    
}
