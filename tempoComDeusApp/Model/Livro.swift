//
//  Livro.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Livro: Decodable {

    var abbrev: [String: String]
    var name: String
    let author: String
    let chapters: Int?
    let group: String?
    let testament: String?
    let version: String?
   
    init(abbrev: [String: String],
         name: String,
         author: String,
         chapters: Int,
         group: String,
         testament: String,
         version: String) {
   
        self.abbrev = abbrev
        self.name = name
        self.author = author
        self.testament = testament
        self.group = group
        self.chapters = chapters
        self.version = version
    }
    private enum CodingKeys: String, CodingKey {
        case  name, abbrev, author, group, chapters, testament, version
    }
    
}
