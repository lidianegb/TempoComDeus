//
//  Chapter.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Chapter: Codable {
    let bookName: String
    let number: Int
    let versicles: [Int: String]
    let version: String
    
    init(book: String, number: Int, versicles: [Int: String], version: String) {
        self.bookName = book
        self.number = number
        self.versicles = versicles
        self.version = version
    }
    
    func formatedTitle() -> String {
        return " \(version.uppercased()) - \(bookName) \(number)"
    }
    
    func getVersiculos() -> [String] {
        var versos: [String] = []
        for (key, value) in versicles {
            versos.append("\(key) \(value)")
        }
        return versos
    }
}
