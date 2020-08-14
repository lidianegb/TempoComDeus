//
//  NotasModel.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

struct Nota{
    var id: Int = Date().hashValue
    let date :String
    let text: String
    let color: String
    
    init(text: String, color: String) {
        self.text = text
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: date)
        self.date = "20 " + monthString
        
        self.color = color
    }
    
}
