//
//  Book.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 01/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Book: Codable {

    var abbrev: [String: String]
    var name: String
    let author: String
    let chapters: Int?
    let group: String?
    let testament: String?
    let version: String?
    var opened: Bool?
   
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
        self.opened = false
    }
    private enum CodingKeys: String, CodingKey {
        case  name, abbrev, author, group, chapters, testament, version, opened
    }
}
