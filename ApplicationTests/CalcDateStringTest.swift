//
//  CalcDateStringTest.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 24/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
// swiftlint:disable trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class CalcDateStringTest: XCTestCase {

    func test_calculate_data_String() {
        // given
        let sut  = NotasCollectionViewCell()
        let input = "20 de agosto"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        guard let date = dateFormatter.date(from: input) else { return  }
    
        let output1 = sut.calcDate(date: date)
        
        XCTAssertEqual(output1, input)
    }
}
