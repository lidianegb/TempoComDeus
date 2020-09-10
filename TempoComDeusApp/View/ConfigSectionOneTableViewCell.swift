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
    
    lazy var uiSwitch: UISwitch = {
        let uiControl = UISwitch()
        uiControl.onTintColor = .blueAct
        uiControl.isOn = UserDefaults.standard.bool(forKey: DARK)
        uiControl.addTarget(self, action: #selector(changeMode), for: .valueChanged)
        return uiControl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func changeMode() {
        if uiSwitch.isOn {
              window?.overrideUserInterfaceStyle = .dark
             defaults.set(true, forKey: DARK)
        } else {
              window?.overrideUserInterfaceStyle = .light
            defaults.set(false, forKey: DARK)
        }
        
        self.reloadInputViews()
    }
    
    func createCell() {
        setupUISwitch()
    }
    
    func setupUISwitch() {
        contentView.addSubview(uiSwitch)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.anchor(top: contentView.topAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 10,
                        paddingRight: 10,
                        width: 50, height: 20)
    }
    
}
