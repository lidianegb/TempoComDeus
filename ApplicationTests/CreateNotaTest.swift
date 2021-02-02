//
//  CreateNotaTest.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 24/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import XCTest
@testable import tempo_com_Deus
class CreateNotaTest: XCTestCase {

    func test_create_newNota_withValues() {
        // given
        let text = "Nota 1"
        let cor = "azul"
        let sut = Note(body: text, color: cor, versos: [])
       // when
       let output1 = sut.body
       let output2 = sut.color
       
       // Then
       XCTAssertEqual(output1, text)
       XCTAssertEqual(output2, cor)
    }
    
    func test_create_newNota_withoutValues() {
           // given

        let sut = Note(body: nil, color: nil, versos: [])
           
          // when
          let output1 = sut.body
          let output2 = sut.color
          
          // Then
          XCTAssertEqual(output1, "")
          XCTAssertEqual(output2, "")
       }
    
}
