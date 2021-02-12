//
//  TestCalculator.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 12/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestCalculator: XCTestCase {

    var sut: Calculator!
    override func setUp() {
        sut = Calculator()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCalculeBooksTableViewCellHeight() {
        var result = Calculator.calculeBooksTableViewCellHeight(totalItems: 1)
        XCTAssertEqual(result, 70)
        
        result = Calculator.calculeBooksTableViewCellHeight(totalItems: 7)
        XCTAssertEqual(result, 70)
        
        result = Calculator.calculeBooksTableViewCellHeight(totalItems: 8)
        XCTAssertEqual(result, 120)
    }
    
    func testCalculeNotesCollectionViewCellSize() {
        let (width,height) = Calculator.calculeNotesCollectionViewCellSize(width: 20, height: 20)
        XCTAssertEqual(width, height)
        XCTAssertEqual(width, 5)
    }

}
