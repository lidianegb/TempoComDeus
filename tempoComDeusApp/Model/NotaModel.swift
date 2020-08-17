//
//  NotasModel.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Nota : Codable{
    var id: UUID
    let body: String
    let date : Date
    let color: String
    
    required init() {
        self.id = UUID()
        self.body = "vazio"
        self.color = "nota1"
        self.date  = Date()
    }
    private enum CodingKeys: String, CodingKey{
           case id, body, date, color
    }
    
}
