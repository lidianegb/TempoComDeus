//
//  Verso.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Verso: Decodable{
    let numero: Int
    let texto: String
    
    init(numero: Int, texto: String) {
        self.numero = numero
        self.texto = texto
    }
    
    enum Codingkeys: String, CodingKey{
        case numero = "number", texto = "text"
    }
}
