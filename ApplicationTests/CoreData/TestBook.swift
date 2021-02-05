//
//  TestBook.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 05/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestBook: XCTestCase {
    var sut: Book!
    override func setUpWithError() throws {
        sut = Book(abbreviation: ["pt": "gn"], name: "Gênesis", author: "Moisés", totalChapters: 50, group: "historicos", testament: "at", version: "nvi")
    }

    override func tearDownWithError() throws {
        sut = nil
    }


    func testAllAttributes() {
        XCTAssertNotNil(sut.abbreviation)
        XCTAssertNotNil(sut.name)
        XCTAssertNotNil(sut.author)
        XCTAssertNotNil(sut.totalChapters)
        XCTAssertNotNil(sut.group)
        XCTAssertNotNil(sut.testament)
        XCTAssertNotNil(sut.version)
    }
}
