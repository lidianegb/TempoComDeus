//
//  CellData.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 19/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

struct CellData {
    var opened = false
    var title = String()
    var items = Int()
}

extension CellData{
    static func data() -> [CellData]{
        return   [CellData(title: "Gênesis", items: 50),
                  CellData(title: "Êxodo", items: 40),
                  CellData(title: "Levítico", items: 27),
                  CellData(title: "Números", items: 36),
                  CellData(title: "Deuteronômio", items: 34),
                  CellData(title: "Josué", items: 24),
                  CellData(title: "Juízes", items: 21),
                  CellData(title: "Rute", items: 4),
                  CellData(title: "1 Samuel", items: 31),
                  CellData(title: "2 Samuel", items: 24),
                  CellData(title: "1 Reis 22", items: 27),
                  CellData(title: "2 Reis 25", items: 27),
                  CellData(title: "1 Crônicas", items: 29),
                  CellData(title: "2 Crônicas", items: 36),
                  CellData(title: "Esdras", items: 10),
                  CellData(title: "Neemias", items: 13),
                  CellData(title: "Ester", items: 10),
                  CellData(title: "Jó", items: 42),
                  CellData(title: "Salmos", items: 150),
                  CellData(title: "Provérbios", items: 31),
                  CellData(title: "Eclesiastes", items: 12),
                  CellData(title: "Cântico dos Cânticos", items: 8),
                  CellData(title: "Isaías", items: 66),
                  CellData(title: "Jeremias", items: 52),
                  CellData(title: "Lamentações", items: 5),
                  CellData(title: "Ezequiel", items: 48),
                  CellData(title: "Daniel", items: 12),
                  CellData(title: "Oseias", items: 14),
                  CellData(title: "Joel", items: 3),
                  CellData(title: "Amós", items: 9),
                  CellData(title: "Obadias", items: 1),
                  CellData(title: "Jonas", items: 4),
                  CellData(title: "Miqueias", items: 7),
                  CellData(title: "Naum", items: 3),
                  CellData(title: "Habacuque", items: 3),
                  CellData(title: "Sofonias", items: 3),
                  CellData(title: "Ageu", items: 2),
                  CellData(title: "Zacarias", items: 14),
                  CellData(title: "Malaquias", items: 4),
                  CellData(title: "Mateus", items: 28),
                  CellData(title: "Marcos", items: 16),
                  CellData(title: "Lucas", items: 24),
                  CellData(title: "João", items: 21),
                  CellData(title: "Atos", items: 28),
                  CellData(title: "Romanos", items: 16),
                  CellData(title: "1 Coríntios", items: 16),
                  CellData(title: "2 Coríntios", items: 13),
                  CellData(title: "Gálatas", items: 6),
                  CellData(title: "Efésios", items: 6),
                  CellData(title: "Filipenses", items: 4),
                  CellData(title: "Colossenses", items: 4),
                  CellData(title: "1 Tessalonicenses", items: 5),
                  CellData(title: "2 Tessalonicenses", items: 3),
                  CellData(title: "1 Timóteo", items: 6),
                  CellData(title: "2 Timóteo", items: 4),
                  CellData(title: "Tito", items: 3),
                  CellData(title: "Filemom", items: 1),
                  CellData(title: "Hebreus", items: 13),
                  CellData(title: "Tiago", items: 5),
                  CellData(title: "1 Pedro", items: 5),
                  CellData(title: "2 Pedro", items: 3),
                  CellData(title: "1 João", items: 5),
                  CellData(title: "2 João", items: 1),
                  CellData(title: "3 João", items: 1),
                  CellData(title: "Judas", items: 1),
                  CellData(title: "Apocalipse", items: 22)]
               
    }
}
