//
//  URL.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
extension URL {
    // retorna os 66 livros da biblia
    static var getLivros: URL{
        URL(string: "https://bibleapi.co/api/books")!
    }
    // retorna todos os versos e detalhes de um capitulo
    static func getCapitulo(abbrev: String, cap: Int) -> URL{
        URL(string: "https://bibleapi.co/api/verses/nvi/\(abbrev)/\(cap)")!
    }
   
}
