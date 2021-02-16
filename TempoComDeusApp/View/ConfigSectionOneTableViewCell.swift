//
//  ConfigSectionOneTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 09/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit
import SwiftUI
class ConfigSectionOneTableViewCell: UITableViewCell {
    
    var theme: Int = 0
    let wrapperView: UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = .backViewColor
        wrapper.layer.cornerRadius = 8
        wrapper.layer.masksToBounds = true
        return wrapper
    }()
    
    lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Modo noturno:"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        return label
    }()
    
    lazy var buttonTheme: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 35, height: 35)
        button.contentMode = .scaleAspectFit
        button.tintColor = .blueAct
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.blueAct.cgColor
        button.accessibilityLabel = "buttonTheme"
        return button
    }()
    
    func configureAppearance() {
        theme = UserDefaults.standard.integer(forKey: THEME)
        if #available(iOS 14.0, *) {
            buttonTheme.showsMenuAsPrimaryAction = true
            buttonTheme.menu = createMenu()
          
        } else {
            // Fallback on earlier versions
        }
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
        buttonTheme.setImage(UIImage(named: "auto_fill"), for: .normal)
    }
    
    func configureLighAppearance() {
        buttonTheme.setImage(UIImage(named: "sun_max_fill"), for: .normal)
    }
    
    func configureDarkAppearance() {
        buttonTheme.setImage(UIImage(named: "moon_fill"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .backgroundColor
        setup()
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
    
    func setup() {
        contentView.addSubview(wrapperView)
        wrapperView.anchor(top: contentView.topAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingBottom: 3)
        
        contentView.addSubview(buttonTheme)
        buttonTheme.translatesAutoresizingMaskIntoConstraints = false
        buttonTheme.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
        buttonTheme.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -16).isActive = true
        
        contentView.addSubview(themeLabel)
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
        themeLabel.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 16).isActive = true

    }
    
    func createMenu() -> UIMenu {
      
      let lightAction = UIAction(
        title: "Modo claro",
        image: UIImage(named: "sun_max_fill")
      ) { (_) in
        self.setLightMode()
      }
      
      let darkAction = UIAction(
        title: "Modo escuro",
        image: UIImage(named: "moon_fill")
      ) { (_) in
        self.setDarkMode()
      }
      
      let autoAction = UIAction(
        title: "Padrão do sistema",
        image: UIImage(named: "auto_fill")
      ) { (_) in
        self.setAutoMode()
      }
      
      let menuActions = [lightAction, darkAction, autoAction]
      
      let addNewMenu = UIMenu(
        title: "",
        children: menuActions)
      
      return addNewMenu
    }
    
}
