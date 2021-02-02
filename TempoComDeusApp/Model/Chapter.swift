//
//  Chapter.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Chapter: Codable {
    var bookName: String
    var abbreviation: String
    var number: Int
    var versicles: [String]
    var version: String
    
    init(book: String = "",
         abbreviation: String = ABBR,
         number: Int = 0, versicles: [String] = [],
         version: String = VERSION) {
        self.abbreviation = abbreviation
        self.bookName = book
        self.number = number
        self.versicles = versicles
        self.version = version
    }
    
    func formatedTitle() -> String {
        "\(bookName) \(number)"
    }
    
    func formatedVersion() -> String {
        version.uppercased()
    }
}
