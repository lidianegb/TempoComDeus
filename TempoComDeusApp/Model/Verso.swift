//
//  Verso.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Verso {
    let livro: String
    let capitulo: Int
    let verso: Int
    let versao: String
    
    init(livro: String, capitulo: Int, verso: Int, versao: String) {
        self.livro = livro
        self.capitulo = capitulo
        self.verso = verso
        self.versao = versao
    }
    
    func formatedTitle() -> String {
        return "\(livro) \(capitulo):\(verso) \(versao.uppercased())"
    }
}
