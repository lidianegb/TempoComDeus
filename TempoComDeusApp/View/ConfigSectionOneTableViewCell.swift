//
//  ConfigSectionOneTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 09/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit

class ConfigSectionOneTableViewCell: UITableViewCell {
    
    var theme: Int = 0
    var stackDark: UIStackView!
    var stackLight: UIStackView!
    var statckAuto: UIStackView!
    let wrapperView: UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = .backViewColor
        wrapper.layer.cornerRadius = 8
        wrapper.layer.masksToBounds = true
        return wrapper
    }()
    
    lazy var labelLightMode: UIButton = {
        let button = UIButton()
        button.setTitle("claro", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(setLightMode), for: .touchUpInside)
        return button
    }()
    
    lazy var labelDarkMode: UIButton = {
        let button = UIButton()
        button.setTitle("escuro", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(setDarkMode), for: .touchUpInside)
        return button
    }()
    
    lazy var labelAutoMode: UIButton = {
        let button = UIButton()
        button.setTitle("automático", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(setAutoMode), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonLight: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 30, height: 30)
        button.setBackgroundImage(UIImage(systemName: "sun.max.fill"), for: .normal)
        button.addTarget(self, action: #selector(setLightMode), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonDark: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 30, height: 30)
        button.setBackgroundImage(UIImage(systemName: "moon.stars.fill"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(setDarkMode), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonAuto: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 30, height: 30)
        button.setBackgroundImage(UIImage(systemName: "sparkles"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(setAutoMode), for: .touchUpInside)
        return button
    }()
    
    func configureAppearance() {
        theme = UserDefaults.standard.integer(forKey: THEME)

        switch theme {
        case 1:
            configureLighAppearance()
        case 2:
            configureDarkAppearance()
        default:
            configureAutoAppearance()
        }
    }
    
    func configureAutoAppearance() {
        buttonDark.tintColor = .systemGray3
        buttonAuto.tintColor = .blueAct
        buttonLight.tintColor = .systemGray3
        labelLightMode.setTitleColor(.secondaryLabel, for: .normal)
        labelDarkMode.setTitleColor(.secondaryLabel, for: .normal)
        labelAutoMode.setTitleColor(.label, for: .normal)
    }
    
    func configureLighAppearance() {
        buttonDark.tintColor = .systemGray3
        buttonAuto.tintColor = .systemGray3
        buttonLight.tintColor = .blueAct
        labelLightMode.setTitleColor(.label, for: .normal)
        labelDarkMode.setTitleColor(.secondaryLabel, for: .normal)
        labelAutoMode.setTitleColor(.secondaryLabel, for: .normal)
    }
    
    func configureDarkAppearance() {
        buttonDark.tintColor = .blueAct
        buttonLight.tintColor = .systemGray3
        buttonAuto.tintColor = .systemGray3
        labelLightMode.setTitleColor(.secondaryLabel, for: .normal)
        labelAutoMode.setTitleColor(.secondaryLabel, for: .normal)
        labelDarkMode.setTitleColor(.label, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .backgroundColor
        setupWrapperView()
        setupButtons()
    }
    
    @objc func setDarkMode() {
        UIView.transition(with: self.window!, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.window?.overrideUserInterfaceStyle = .dark
                            UserDefaultsPersistence.shared.setKeyTheme(theme: 2)
                            self.configureDarkAppearance()
                            self.layoutIfNeeded()
                          },
                          completion: nil)
        
    }

    @objc func setLightMode() {
        UIView.transition(with: self.window!, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.window?.overrideUserInterfaceStyle = .light
                            UserDefaultsPersistence.shared.setKeyTheme(theme: 1)
                            self.configureLighAppearance()
                            self.layoutIfNeeded()
                          },
                          completion: nil)
    }
    
    @objc func setAutoMode() {
    
        UIView.transition(with: self.window!, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.window?.overrideUserInterfaceStyle = .unspecified
                            UserDefaultsPersistence.shared.setKeyTheme(theme: 0)
                            self.configureAppearance()
                            self.layoutIfNeeded()
                          },
                          completion: nil)
    }
    
    func setupWrapperView() {
        contentView.addSubview(wrapperView)
        wrapperView.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingBottom: 3)
    }
    
    func setupButtons() {
        stackLight = UIStackView(arrangedSubviews: [buttonLight, labelLightMode])
        stackLight.distribution = .equalCentering
        stackLight.spacing = 8
        stackLight.alignment = .center
        stackLight.axis = .horizontal
    
        stackDark = UIStackView(arrangedSubviews: [buttonDark, labelDarkMode])
        stackDark.distribution = .equalCentering
        stackDark.spacing = 8
        stackDark.alignment = .center
        stackDark.axis = .horizontal

        statckAuto = UIStackView(arrangedSubviews: [buttonAuto, labelAutoMode])
        statckAuto.distribution = .equalCentering
        statckAuto.alignment = .center
        stackDark.spacing = 8
        statckAuto.axis = .horizontal
        
        let stack = UIStackView(arrangedSubviews: [stackLight, stackDark, statckAuto])
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.axis = .horizontal
        
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.anchor(top: wrapperView.topAnchor,
                     left: wrapperView.leftAnchor,
                     bottom: wrapperView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 2, paddingLeft: 8, paddingBottom: 2, paddingRight: 8)

    }
    
}
