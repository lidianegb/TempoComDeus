//
//  LivrosDataTest.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 26/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
//swiftlint:disable trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class LivrosDataTest: XCTestCase {
    
    func test_livrosData_equals66() {
        let sut = LivrosData.data()
        
        let input = sut.count
        
        let output = 66
        
        XCTAssertEqual(output, input)
    }

}
