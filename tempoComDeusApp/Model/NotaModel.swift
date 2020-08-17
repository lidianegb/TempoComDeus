//
//  NotasModel.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

struct Nota : Codable{
    var id: UUID
    let text: String?
    let date : TimeInterval?
    let color: String?
    
    init(id: UUID = UUID(), text: String? = nil, color: String? = nil, date: TimeInterval = Date().timeIntervalSince1970) {
        self.id = id
        self.text = text
        self.color = color
        self.date  = date
    }
    private enum CodingKeys: String, CodingKey{
           case id, text, date, color
    }
    
}
