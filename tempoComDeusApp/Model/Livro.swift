//
//  Livro.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Livro: Decodable{
    
    let id: UUID
    var nome: String
    let abreviacao: String
    let autor: String
    let testamento: String
    let grupo: String
    let capitulos : Int
  
    
    required init(id:UUID = UUID(), nome: String, abreviacao: String, autor: String, testamento:String, grupo: String, capitulos: Int) {
        self.id = id
        self.nome = nome
        self.abreviacao = abreviacao
        self.autor = autor
        self.testamento = testamento
        self.grupo = grupo
        self.capitulos = capitulos
    }
    private enum CodingKeys: String, CodingKey{
        case id, nome = "name", abreviacao = "abbrev", autor = "author", testamento = "testament", grupo = "group", capitulos = "chapters"
    }
    
}
