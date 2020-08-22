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
    var abbrev = String()
    var items = Int()
}

extension CellData {
    static func data() -> [CellData] {
        return   [CellData(title: "Gênesis", abbrev: "gn", items: 50),
                  CellData(title: "Êxodo", abbrev: "ex", items: 40),
                  CellData(title: "Levítico", abbrev: "lv", items: 27),
                  CellData(title: "Números", abbrev: "nm", items: 36),
                  CellData(title: "Deuteronômio", abbrev: "dt", items: 34),
                  CellData(title: "Josué", abbrev: "js", items: 24),
                  CellData(title: "Juízes", abbrev: "jz", items: 21),
                  CellData(title: "Rute", abbrev: "rt", items: 4),
                  CellData(title: "1 Samuel", abbrev: "1sm", items: 31),
                  CellData(title: "2 Samuel", abbrev: "2sm", items: 24),
                  CellData(title: "1 Reis", abbrev: "1rs", items: 22),
                  CellData(title: "2 Reis", abbrev: "2rs", items: 25),
                  CellData(title: "1 Crônicas", abbrev: "1cr", items: 29),
                  CellData(title: "2 Crônicas", abbrev: "2cr", items: 36),
                  CellData(title: "Esdras", abbrev: "ed", items: 10),
                  CellData(title: "Neemias", abbrev: "ne", items: 13),
                  CellData(title: "Ester", abbrev: "et", items: 10),
                  CellData(title: "Jó", abbrev: "job", items: 42),
                  CellData(title: "Salmos", abbrev: "sl", items: 150),
                  CellData(title: "Provérbios", abbrev: "pv", items: 31),
                  CellData(title: "Eclesiastes", abbrev: "ec", items: 12),
                  CellData(title: "Cântico dos Cânticos", abbrev: "ct", items: 8),
                  CellData(title: "Isaías", abbrev: "is", items: 66),
                  CellData(title: "Jeremias", abbrev: "jr", items: 52),
                  CellData(title: "Lamentações", abbrev: "lm", items: 5),
                  CellData(title: "Ezequiel", abbrev: "ez", items: 48),
                  CellData(title: "Daniel", abbrev: "dn", items: 12),
                  CellData(title: "Oseias", abbrev: "os", items: 14),
                  CellData(title: "Joel", abbrev: "jl", items: 3),
                  CellData(title: "Amós", abbrev: "am", items: 9),
                  CellData(title: "Obadias", abbrev: "ob", items: 1),
                  CellData(title: "Jonas", abbrev: "jn", items: 4),
                  CellData(title: "Miqueias", abbrev: "mq", items: 7),
                  CellData(title: "Naum", abbrev: "na", items: 3),
                  CellData(title: "Habacuque", abbrev: "hc", items: 3),
                  CellData(title: "Sofonias", abbrev: "sf", items: 3),
                  CellData(title: "Ageu", abbrev: "ag", items: 2),
                  CellData(title: "Zacarias", abbrev: "zc", items: 14),
                  CellData(title: "Malaquias", abbrev: "ml", items: 4),
                  CellData(title: "Mateus", abbrev: "mt", items: 28),
                  CellData(title: "Marcos", abbrev: "mc", items: 16),
                  CellData(title: "Lucas", abbrev: "lc", items: 24),
                  CellData(title: "João", abbrev: "jo", items: 21),
                  CellData(title: "Atos", abbrev: "at", items: 28),
                  CellData(title: "Romanos", abbrev: "rm", items: 16),
                  CellData(title: "1 Coríntios", abbrev: "1co", items: 16),
                  CellData(title: "2 Coríntios", abbrev: "2co", items: 13),
                  CellData(title: "Gálatas", abbrev: "gl", items: 6),
                  CellData(title: "Efésios", abbrev: "ef", items: 6),
                  CellData(title: "Filipenses", abbrev: "fp", items: 4),
                  CellData(title: "Colossenses", abbrev: "cl", items: 4),
                  CellData(title: "1 Tessalonicenses", abbrev: "1ts", items: 5),
                  CellData(title: "2 Tessalonicenses", abbrev: "2ts", items: 3),
                  CellData(title: "1 Timóteo", abbrev: "1tm", items: 6),
                  CellData(title: "2 Timóteo", abbrev: "2tm", items: 4),
                  CellData(title: "Tito", abbrev: "tt", items: 3),
                  CellData(title: "Filemom", abbrev: "fm", items: 1),
                  CellData(title: "Hebreus", abbrev: "hb", items: 13),
                  CellData(title: "Tiago", abbrev: "tg", items: 5),
                  CellData(title: "1 Pedro", abbrev: "1pe", items: 5),
                  CellData(title: "2 Pedro", abbrev: "2pe", items: 3),
                  CellData(title: "1 João", abbrev: "1jo", items: 5),
                  CellData(title: "2 João", abbrev: "2jo", items: 1),
                  CellData(title: "3 João", abbrev: "3jo", items: 1),
                  CellData(title: "Judas", abbrev: "jd", items: 1),
                  CellData(title: "Apocalipse", abbrev: "ap", items: 22)]
               
    }
}
