//
//  UIPickerBibliaViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 06/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

extension BibleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar(frame:
            CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.backgroundColor = .blueOff
        toolBar.isTranslucent = true
        toolBar.tintColor = .blueAct
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self, action: #selector(dmissPicker))
        toolBar.setItems([flexible, doneButton], animated: true)
        
        versionButton.inputView = picker
        versionButton.inputAccessoryView = toolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataPicker.count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        let attributedString =
            NSAttributedString(string: dataPicker[row].name + " - " + dataPicker[row].abbrev.uppercased(),
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.label])
           return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        version = dataPicker[row].abbrev
        bible.booksResume = File().readBibleByVersion(version: version)
        actualBook = bible.getActualBook(abbreviation: abbrev)
    }
    
    @objc func dmissPicker() {
        versionButton.resignFirstResponder()
    }
}
