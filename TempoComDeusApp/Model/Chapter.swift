//
//  Chapter.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
class Chapter: Codable {
    var bookName: String
    var abbreviation: String
    var number: Int
    var versicles: [String]
    var version: String
    var totalVerses: Int {
        versicles.count
    }
    
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
    
    init(bible: Bible, number: Int) {
        self.bookName = bible.actualBook?.name ?? ""
        self.abbreviation = bible.actualBook?.abbreviation ?? "gn"
        self.number = number
        self.versicles = bible.actualBook?.getVersesByChapter(chapter: number) ?? []
        self.version = bible.version 
    }
    
    func update(bible: Bible) {
        self.bookName = bible.actualBook?.name ?? ""
        self.abbreviation = bible.actualBook?.abbreviation ?? "gn"
        self.versicles = bible.actualBook?.getVersesByChapter(chapter: number) ?? []
        self.version = bible.version
    }
    
    func formatedTitle() -> String {
        "\(bookName) \(number + 1)"
    }
    
    func formatedVersion() -> String {
        version.uppercased()
    }
    
    func getTextVerse(verseNumber: Int) -> String {
        versicles[verseNumber]
    }
    
    func getSelectedVerses(selectedIndexes: [Int]) -> String {
        var formattedText: String = bookName + " \(number + 1)"
        for index in selectedIndexes {
            formattedText += "\n\(index + 1). " + versicles[index]
        }
       return formattedText
    }
}
