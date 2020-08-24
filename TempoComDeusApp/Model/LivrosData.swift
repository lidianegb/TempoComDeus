//
//  LivrosData.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 19/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

struct LivrosData {
    var opened = false
    var title: String
    var abbrev: String
    var items: Int
}

// swiftlint:disable function_body_length
extension LivrosData {
    static func data() -> [LivrosData] {
        return   [LivrosData(title: "Gênesis", abbrev: "gn", items: 50),
                  LivrosData(title: "Êxodo", abbrev: "ex", items: 40),
                  LivrosData(title: "Levítico", abbrev: "lv", items: 27),
                  LivrosData(title: "Números", abbrev: "nm", items: 36),
                  LivrosData(title: "Deuteronômio", abbrev: "dt", items: 34),
                  LivrosData(title: "Josué", abbrev: "js", items: 24),
                  LivrosData(title: "Juízes", abbrev: "jz", items: 21),
                  LivrosData(title: "Rute", abbrev: "rt", items: 4),
                  LivrosData(title: "1 Samuel", abbrev: "1sm", items: 31),
                  LivrosData(title: "2 Samuel", abbrev: "2sm", items: 24),
                  LivrosData(title: "1 Reis", abbrev: "1rs", items: 22),
                  LivrosData(title: "2 Reis", abbrev: "2rs", items: 25),
                  LivrosData(title: "1 Crônicas", abbrev: "1cr", items: 29),
                  LivrosData(title: "2 Crônicas", abbrev: "2cr", items: 36),
                  LivrosData(title: "Esdras", abbrev: "ed", items: 10),
                  LivrosData(title: "Neemias", abbrev: "ne", items: 13),
                  LivrosData(title: "Ester", abbrev: "et", items: 10),
                  LivrosData(title: "Jó", abbrev: "job", items: 42),
                  LivrosData(title: "Salmos", abbrev: "sl", items: 150),
                  LivrosData(title: "Provérbios", abbrev: "pv", items: 31),
                  LivrosData(title: "Eclesiastes", abbrev: "ec", items: 12),
                  LivrosData(title: "Cântico dos Cânticos", abbrev: "ct", items: 8),
                  LivrosData(title: "Isaías", abbrev: "is", items: 66),
                  LivrosData(title: "Jeremias", abbrev: "jr", items: 52),
                  LivrosData(title: "Lamentações", abbrev: "lm", items: 5),
                  LivrosData(title: "Ezequiel", abbrev: "ez", items: 48),
                  LivrosData(title: "Daniel", abbrev: "dn", items: 12),
                  LivrosData(title: "Oseias", abbrev: "os", items: 14),
                  LivrosData(title: "Joel", abbrev: "jl", items: 3),
                  LivrosData(title: "Amós", abbrev: "am", items: 9),
                  LivrosData(title: "Obadias", abbrev: "ob", items: 1),
                  LivrosData(title: "Jonas", abbrev: "jn", items: 4),
                  LivrosData(title: "Miqueias", abbrev: "mq", items: 7),
                  LivrosData(title: "Naum", abbrev: "na", items: 3),
                  LivrosData(title: "Habacuque", abbrev: "hc", items: 3),
                  LivrosData(title: "Sofonias", abbrev: "sf", items: 3),
                  LivrosData(title: "Ageu", abbrev: "ag", items: 2),
                  LivrosData(title: "Zacarias", abbrev: "zc", items: 14),
                  LivrosData(title: "Malaquias", abbrev: "ml", items: 4),
                  LivrosData(title: "Mateus", abbrev: "mt", items: 28),
                  LivrosData(title: "Marcos", abbrev: "mc", items: 16),
                  LivrosData(title: "Lucas", abbrev: "lc", items: 24),
                  LivrosData(title: "João", abbrev: "jo", items: 21),
                  LivrosData(title: "Atos", abbrev: "at", items: 28),
                  LivrosData(title: "Romanos", abbrev: "rm", items: 16),
                  LivrosData(title: "1 Coríntios", abbrev: "1co", items: 16),
                  LivrosData(title: "2 Coríntios", abbrev: "2co", items: 13),
                  LivrosData(title: "Gálatas", abbrev: "gl", items: 6),
                  LivrosData(title: "Efésios", abbrev: "ef", items: 6),
                  LivrosData(title: "Filipenses", abbrev: "fp", items: 4),
                  LivrosData(title: "Colossenses", abbrev: "cl", items: 4),
                  LivrosData(title: "1 Tessalonicenses", abbrev: "1ts", items: 5),
                  LivrosData(title: "2 Tessalonicenses", abbrev: "2ts", items: 3),
                  LivrosData(title: "1 Timóteo", abbrev: "1tm", items: 6),
                  LivrosData(title: "2 Timóteo", abbrev: "2tm", items: 4),
                  LivrosData(title: "Tito", abbrev: "tt", items: 3),
                  LivrosData(title: "Filemom", abbrev: "fm", items: 1),
                  LivrosData(title: "Hebreus", abbrev: "hb", items: 13),
                  LivrosData(title: "Tiago", abbrev: "tg", items: 5),
                  LivrosData(title: "1 Pedro", abbrev: "1pe", items: 5),
                  LivrosData(title: "2 Pedro", abbrev: "2pe", items: 3),
                  LivrosData(title: "1 João", abbrev: "1jo", items: 5),
                  LivrosData(title: "2 João", abbrev: "2jo", items: 1),
                  LivrosData(title: "3 João", abbrev: "3jo", items: 1),
                  LivrosData(title: "Judas", abbrev: "jd", items: 1),
                  LivrosData(title: "Apocalipse", abbrev: "ap", items: 22)]
               
    }
}
