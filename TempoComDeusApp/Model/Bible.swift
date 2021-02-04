//
//  Bible.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import Foundation

class Bible {
    private var booksResume = [BookResume]()
    var actualBook: BookResume?
    var version: String {
        didSet {
            self.booksResume = File().readBibleByVersion(version: version)
            actualBook = getActualBook(abbreviation: abbreviation)
        }
    }
    var abbreviation: String {
        didSet {
            self.actualBook = getActualBook(abbreviation: abbreviation)
        }
    }
    var allBooks = [Book]()
    
    init(version: String, abbreviation: String) {
        self.version = version
        self.abbreviation = abbreviation
        self.allBooks = File().readBiblia()
        self.booksResume = File().readBibleByVersion(version: version)
        self.actualBook = getActualBook(abbreviation: abbreviation)
    }
    
    func updateActualVersion(version: String) {
        self.version = version
    }
    
    func updateActualBook(abbreviation: String) {
        self.abbreviation = abbreviation
    }
    
    private func getActualBook(abbreviation: String) -> BookResume? {
        booksResume.filter {$0.abbreviation == abbreviation}.first
    }
    
    func getNextBook() -> Book? {
        for (indice, book) in self.allBooks.enumerated()
        where book.abbreviation["pt"] == actualBook?.abbreviation
            && indice < self.allBooks.count - 1 {
                return allBooks[indice + 1]
            
        }
        return nil
    }
    
    func getPreviewBook() -> Book? {
        for (indice, book) in self.allBooks.enumerated()
        where book.abbreviation["pt"] == actualBook?.abbreviation
        && indice > 0 {
            return allBooks[indice - 1]
        }
        return nil
    }
}
