//
//  TestBookResume.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 05/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestBookResume: XCTestCase {
    var sut: BookResume!
    override func setUpWithError() throws {
        sut = BookResume(abbrev: "gn", chapters: [["livro1"], ["livro2"]], name: "Gênesis")
    }
    
    func testGetVersesByChapter() {
        let verse = sut.getVersesByChapter(chapter: 0)
        XCTAssertEqual(verse, ["livro1"])
    }
    
    func testGetNextChapter() {
        let nextChapter = sut.getNextChapter(actualChapter: 0)
        XCTAssertEqual(nextChapter, 1)
    }
    
    func testGetNextChapter_returnNil() {
        let nextChapter = sut.getNextChapter(actualChapter: 1)
        XCTAssertNil(nextChapter)
    }
    
    func testPreviewChapter() {
        let nextChapter = sut.getPreviewChapter(actualChapter: 1)
        XCTAssertEqual(nextChapter, 0)
    }
    
    func testGetPreviewChapter_returnNil() {
        let nextChapter = sut.getPreviewChapter(actualChapter: 0)
        XCTAssertNil(nextChapter)
    }

    override func tearDownWithError() throws {
       sut = nil
    }

}
