//
//  BookResume.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 03/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
class BookResume: Codable {
    let abbreviation: String
    let chapters: [[String]]
    let name: String
    var totalChapters: Int {
        chapters.count
    }
    
    init(abbrev: String, chapters: [[String]], name: String) {
        self.abbreviation = abbrev
        self.chapters = chapters
        self.name = name
    }
    enum CodingKeys: String, CodingKey {
        case abbreviation = "abbrev", chapters, name
    }
    
    func getVersesByChapter(chapter: Int) -> [String] {
        return chapters[chapter]
    }
}
