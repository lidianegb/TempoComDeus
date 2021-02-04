//
//  Book.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 01/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
class Book: Codable {
    var abbreviation: [String: String]
    var name: String
    let author: String
    let totalChapters: Int?
    let group: String?
    let testament: String?
    let version: String?
    var opened: Bool?
    var chapters: [[String]] = []
   
    init(abbreviation: [String: String],
         name: String,
         author: String,
         totalChapters: Int,
         group: String,
         testament: String,
         version: String) {
   
        self.abbreviation = abbreviation
        self.name = name
        self.author = author
        self.testament = testament
        self.group = group
        self.totalChapters = totalChapters
        self.version = version
        self.opened = false
    }
    
    private enum CodingKeys: String, CodingKey {
        case  name, abbreviation = "abbrev", author, group, totalChapters = "chapters", testament, version, opened
    }
}
