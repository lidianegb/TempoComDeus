//
//  Capitulo.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Capitulo: Decodable{
    let number: Int
    let verses: Int
    
    init(number: Int, verses: Int) {
        self.number = number
        self.verses = verses
    }
    
    enum CodingKeys: String, CodingKey{
        case number = "number", verses = "verses"
    }
}
