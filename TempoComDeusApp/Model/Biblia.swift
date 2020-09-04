//
//  Biblia.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Biblia: Codable {
    let abbrev: String
    let chapters: [[String]]
    
    init(abbrev: String, chapters: [[String]]) {
        self.abbrev = abbrev
        self.chapters = chapters
    }
    enum CodingKeys: String, CodingKey {
        case abbrev, chapters
    }
    
}
