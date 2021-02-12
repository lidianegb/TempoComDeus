//
//  TestBible.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 12/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestBible: XCTestCase {
    var sut: Bible!
    override func setUp() {
        sut = Bible(version: "nvi", abbreviation: "gn")
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testUpdateActualBook() {
        let actualAbrreviation = sut.abbreviation
        let newAbbreviation = "lc"
        sut.updateActualBook(abbreviation: newAbbreviation)
        XCTAssertNotEqual(sut.abbreviation, actualAbrreviation)
        XCTAssertEqual(sut.abbreviation, newAbbreviation)
    }
    
    func testUpdateActualVersion() {
        let actualVersion = sut.version
        let newVersion = "aa"
        sut.updateActualVersion(version: newVersion)
        XCTAssertEqual(sut.version, newVersion)
        XCTAssertNotEqual(sut.version, actualVersion)
    }
    
    func testGetNextBook() {
        let nextBook = sut.getNextBook()
        XCTAssertNotNil(nextBook)
        let nextAbbreviation = "ex"
        let abbrev = nextBook!.abbreviation["pt"]
        XCTAssertEqual(abbrev, nextAbbreviation)
    }
    
    func testGetNextBook_returnNil() {
        sut.updateActualBook(abbreviation: "ap")
        XCTAssertNil(sut.getNextBook())
    }
    
    func testGetPreviewBook_returnNil() {
        XCTAssertNil(sut.getPreviewBook())
    }
    
    func testGetPreviewBook() throws {
        sut.updateActualBook(abbreviation: "lc")
        let previewAbbreviation = "mc"
        let previewBook = sut.getPreviewBook()
        XCTAssertNotNil(previewBook)
        let abbrev = previewBook!.abbreviation["pt"]
        XCTAssertEqual(abbrev, previewAbbreviation)
    }
}
