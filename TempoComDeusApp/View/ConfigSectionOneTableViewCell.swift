//
//  ConfigSectionOneTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 09/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit

class ConfigSectionOneTableViewCell: UITableViewCell {
    
    let defaults = UserDefaults.standard
    var darkMode = UserDefaults.standard.bool(forKey: DARK)
    var stackDark: UIStackView!
    var stackLight: UIStackView!
    let wrapperView: UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = .backViewColor
        wrapper.layer.cornerRadius = 8
        wrapper.layer.masksToBounds = true
        return wrapper
    }()
    
    lazy var labelModoClaro: UIButton = {
        let button = UIButton()
        button.setTitle("Modo claro", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.tintColor = .secondaryLabel
        button.addTarget(self, action: #selector(setLightMode), for: .touchUpInside)
        return button
    }()
    
    lazy var labelModoEscuro: UIButton = {
        let button = UIButton()
        button.setTitle("Modo escuro", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.tintColor = .secondaryLabel
        button.addTarget(self, action: #selector(setDarkMode), for: .touchUpInside)
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
        button.setBackgroundImage(UIImage(systemName: "moon.fill"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(setDarkMode), for: .touchUpInside)
        return button
    }()
    
    func configureAppearance() {
        darkMode = UserDefaults.standard.bool(forKey: DARK)
        if darkMode {
            buttonDark.tintColor = .blueAct
            buttonLight.tintColor = .systemGray3
            labelModoClaro.setTitleColor(.secondaryLabel, for: .normal)
            labelModoEscuro.setTitleColor(.label, for: .normal)
            
        } else {
            buttonDark.tintColor = .systemGray3
            buttonLight.tintColor = .blueAct
            labelModoClaro.setTitleColor(.label, for: .normal)
            labelModoEscuro.setTitleColor(.secondaryLabel, for: .normal)
        }
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
                            self.defaults.set(true, forKey: DARK)
                            self.configureAppearance()
                            self.layoutIfNeeded()
                          },
                          completion: nil)
        
    }

    @objc func setLightMode() {
        UIView.transition(with: self.window!, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.window?.overrideUserInterfaceStyle = .light
                            self.defaults.set(false, forKey: DARK)
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
        stackLight = UIStackView(arrangedSubviews: [buttonLight, labelModoClaro])
        stackLight.distribution = .equalCentering
        stackLight.spacing = 8
        stackLight.alignment = .center
        stackLight.axis = .horizontal
        
        contentView.addSubview(stackLight)
        stackLight.translatesAutoresizingMaskIntoConstraints = false
        stackLight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackLight.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 8).isActive = true
        
        stackDark = UIStackView(arrangedSubviews: [buttonDark, labelModoEscuro])
        stackDark.distribution = .equalCentering
        stackDark.spacing = 8
        stackDark.alignment = .center
        stackDark.axis = .horizontal
        
        contentView.addSubview(stackDark)
        stackDark.translatesAutoresizingMaskIntoConstraints = false
        stackDark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackDark.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -8).isActive = true

    }
    
}
