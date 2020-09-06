//
//  UIPickerBibliaViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 06/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

extension BibliaViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataPicker[row].uppercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        version = dataPicker[row]
        allLivros = File().readBibleByVersion(version: version)
        livroAtual = getLivroAtual(abreviacao: abbrev)
        dmissPicker()
    }

}
