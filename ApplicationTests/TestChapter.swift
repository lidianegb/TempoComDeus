//
//  TestChapter.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 12/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestChapter: XCTestCase {
    var sut: Chapter!
    var verse1 = "verse1"
    var verse2 = "verse2"
    var bible = Bible(version: "nvi", abbreviation: "gn")
    override func setUpWithError() throws {
        sut = Chapter(bookName: "teste", abbreviation: "tst", number: 1, versicles: [verse1, verse2], version: "nvi")
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testUpdate() {
        sut.update(bible: bible)
        XCTAssertEqual(sut.abbreviation, bible.abbreviation)
    }
    
    func testGetTextVerse() {
        let verse = sut.getTextVerse(verseNumber: 0)
        XCTAssertEqual(verse, verse1)
    }
    
    func testgetReferenceVerse() {
        let referenceVerse = sut.bookName + " \(sut.number + 1): \(1)\n"
        let referenceVerseTest = sut.getReferenceVerse(selectedIndex: IndexPath(row: 0, section: 0))
        XCTAssertEqual(referenceVerse, referenceVerseTest)
    }
    
    func testgetSelectedVersesText() {
        let selectedVerses = sut.bookName + " \(sut.number + 1)"
        let selectedVersesTest = sut.getSelectedVersesText(selectedIndexes: [])
        XCTAssertEqual(selectedVerses, selectedVersesTest)
        
        let selectedVerses2 = sut.bookName + " \(sut.number + 1)" + "\n1. " + verse1
        let selectedVersesTest2 = sut.getSelectedVersesText(selectedIndexes: [IndexPath(row: 0, section: 0)])
        XCTAssertEqual(selectedVerses2, selectedVersesTest2)
    }
    
}
