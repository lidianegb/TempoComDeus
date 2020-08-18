//
//  Biblia.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Biblia: Decodable{
    let verses: [Verso]
    let chapter: Dictionary<String, Int>
    let book: Livro
  
 
    init(book: Livro, chapter: Dictionary<String, Int>, verses: [Verso]) {
        self.book = book
        self.chapter = chapter
        self.verses = verses
    }
    enum CodingKeys: String, CodingKey{
        case book = "book", chapter = "chapter", verses = "verses"
    }
    
}
