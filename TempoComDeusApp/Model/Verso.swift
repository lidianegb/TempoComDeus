//
//  Verso.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Verso: Codable {
    let livro: String
    let capitulo: Int
    let versiculos: [Int: String]
    let versao: String
    
    init(livro: String, capitulo: Int, versiculos: [Int: String], versao: String) {
        self.livro = livro
        self.capitulo = capitulo
        self.versiculos = versiculos
        self.versao = versao
    }
    
    func formatedTitle() -> String {
        return " \(versao.uppercased()) - \(livro) \(capitulo)"
    }
    
    func getVersiculos() -> [String] {
        var versos: [String] = []
        for (key, value) in versiculos {
            versos.append("\(key) \(value)")
        }
        return versos
    }
}
