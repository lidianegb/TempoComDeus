//
//  Biblia.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Biblia: Decodable {
    let verses: [Verso]
    let chapter: Capitulo
    let book: Livro
  
    init(book: Livro, chapter: Capitulo, verses: [Verso]) {
        self.book = book
        self.chapter = chapter
        self.verses = verses
    }
    enum CodingKeys: String, CodingKey {
        case book, chapter, verses
    }
    
}
