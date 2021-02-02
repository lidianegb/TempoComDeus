//
//  Bible.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

class Bible {
    var booksResume = [BookResume]()
    var books = [Book]()
    
    func getActualBook(abbreviation: String) -> BookResume? {
        booksResume.filter {$0.abbrev == abbreviation}.first ?? nil
    }
}
