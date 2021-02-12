//
//  TestMyColors.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 12/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestMyColors: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetColorNumber_withValidcgColor() {
        let cgColorValidNumber = UIColor.noteColor1.cgColor
        let numberColor = MyColors.getColorNumber(color: cgColorValidNumber)
        XCTAssertEqual(numberColor, 1)
    }
    
    func testGetColorNumber_withInValidcgColor() {
        let cgColorInvalidNumber = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        let numberColor = MyColors.getColorNumber(color: cgColorInvalidNumber)
        XCTAssertEqual(numberColor, 0)
    }

}
