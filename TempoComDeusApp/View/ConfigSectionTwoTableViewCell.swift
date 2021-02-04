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
     
     let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "Fonte:"
         label.textAlignment = .left
         label.numberOfLines = 1
         label.font = .systemFont(ofSize: 17, weight: .medium)
         label.textColor = .label
         return label
     }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.text = "Texto Exemplo"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.layer.borderColor = UIColor.systemGray3.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var stepperControl: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 17
        stepper.maximumValue = 28
        stepper.stepValue = 1
        stepper.value = Double(UserDefaultsPersistence.shared.getDefaultFontSize())
        stepper.setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        stepper.setIncrementImage(UIImage(systemName: "plus"), for: .normal)
        stepper.layer.cornerRadius = 8
        stepper.layer.masksToBounds = true
        stepper.autorepeat = true
        stepper.addTarget(self, action: #selector(changeFontValue), for: .touchUpInside)
        return stepper
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func changeFontValue() {
        let fontSize = Int(stepperControl.value)
        UserDefaultsPersistence.shared.updateFontSize(size: fontSize)
        exampleLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .backgroundColor
        setupWrapperView()
        setupTitleLabel()
        setupStepper()
        setupExampleLabel()
    }
    
    func setupFonteSize() {
        let fontSize = UserDefaultsPersistence.shared.getDefaultFontSize()
        stepperControl.value = Double(fontSize)
        exampleLabel.font = .systemFont(ofSize: CGFloat(fontSize))
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
    
    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: wrapperView.topAnchor,
                          left: wrapperView.leftAnchor,
                          paddingTop: 8, paddingLeft: 8)
    }
    
    func setupStepper() {
        contentView.addSubview(stepperControl)
        stepperControl.anchor(top: wrapperView.topAnchor,
                              right: wrapperView.rightAnchor,
                              paddingTop: 8, paddingRight: 8)
    }
    
    func setupExampleLabel() {
        contentView.addSubview(exampleLabel)
        exampleLabel.anchor(top: stepperControl.bottomAnchor,
                            left: wrapperView.leftAnchor,
                            right: wrapperView.rightAnchor,
                            paddingTop: 12, paddingLeft: 8,
                            paddingRight: 8, height: 40)
    }
}
