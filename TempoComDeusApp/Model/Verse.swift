//
//  Verse.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 08/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class Verse {
    var abbreviation: String
    var chapterNumber: Int
    var verseNumber: Int
    var verseText: String
    var isHighlighted: Bool
    var noteId: UUID?
    
    init(abbreviation: String, chapterNumber: Int,
         verseNumber: Int, verseText: String,
         isHighlighted: Bool = false, noteId: UUID? = nil) {
        self.abbreviation = abbreviation
        self.chapterNumber = chapterNumber
        self.verseNumber = verseNumber
        self.verseText = verseText
        self.isHighlighted = isHighlighted
        self.noteId = noteId
    }
    
    func setHighlighted(isHighlighted: Bool) {
        self.isHighlighted = isHighlighted
    }
    
    func updateNoteId(noteId: UUID?) {
        self.noteId = noteId
    }
}
