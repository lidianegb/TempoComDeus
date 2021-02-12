//
//  TestVerse.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 12/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import Foundation
import XCTest
@testable import tempo_com_Deus
class TestVerse: XCTestCase {
    var sut: Verse!
    override func setUp() {
        super.setUp()
        sut = Verse(abbreviation: "aa", chapterNumber: 1, verseNumber: 2, verseText: "example")
    }
    
    func testSetHighlighted() {
        let highlighted = true
        sut.setHighlighted(isHighlighted: highlighted)
        
        XCTAssertEqual(sut.isHighlighted, highlighted)
    }
    
    func testUpdateNoteId() {
        let noteId = UUID()
        sut.updateNoteId(noteId: noteId)
        
        XCTAssertEqual(sut.noteId, noteId)
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
}
