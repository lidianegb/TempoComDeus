//
//  CalcCellDimensions.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 22/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
// swiftlint:disable trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class CalcCellDimensions: XCTestCase {
    func test_cell_width_height() {
        // given
       let sut = NotasViewController()
       let width = 300.0
       let height = 700.0
        
        // when
        let output1 = sut.calcCellWidthAndHeight(width: CGFloat(width), height: CGFloat(height))
        
        // Then
        XCTAssertEqual(output1, CGSize(width: 135, height: 130))          
    }
}
