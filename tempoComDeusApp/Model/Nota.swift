//
//  NotasModel.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Nota : Codable{
    
    let id: UUID
    var body: String
    let date : Date
    
    required init() {
        self.id = UUID()
        self.body = " "
        self.date  = Date()
    }
    private enum CodingKeys: String, CodingKey{
           case id, body, date
    }
    
}
