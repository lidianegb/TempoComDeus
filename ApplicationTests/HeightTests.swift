//
//  HeigthTests.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 22/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
// swiftlint disable: trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class HeightTests: XCTestCase {
    func test_one_row_height() {
        // given
        let sut = LivrosTableViewController()
        let input1 = 1.0
        let input2 = 7.0
        let input3 = 150.0
        
        //when
        let output1 = sut.calculaHeight(qtdItems: input1)
        let output2 = sut.calculaHeight(qtdItems: input2)
        let output3 = sut.calculaHeight(qtdItems: input3)
        
        //Then
        XCTAssertEqual(output1, 70.0)
        XCTAssertEqual(output2, 70.0)
        XCTAssertEqual(output3, 1120.0)
    }

}
