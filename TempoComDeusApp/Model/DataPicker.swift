//
//  DataPicker.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 10/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class DataPicker {
    let abbrev: String
    let name: String
    
    init(abbrev: String, name: String) {
        self.abbrev = abbrev
        self.name = name
    }
    
    static func data() -> [DataPicker] {
        var data = [DataPicker]()
        data.append(DataPicker(abbrev: NVI, name: "Nova Versão Internacional"))
        data.append(DataPicker(abbrev: AA, name: "Almeida Revisada Impressa"))
        data.append(DataPicker(abbrev: ACF, name: "Almeida Corrigida Fiel"))
        return data
    }
}
