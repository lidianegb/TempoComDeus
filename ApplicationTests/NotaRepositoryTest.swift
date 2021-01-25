//
//  NotaRepositoryTest.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 26/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
// swiftlint:disable trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class NotaRepositoryTest: XCTestCase {
        
    let sut = NotaRepository()
    
    func test_criarNotaRepository_with_itemsEmpty() {
        let input = sut.items.count
        
        let output = 0
        
        XCTAssertEqual(output, input)
    }
    
    func test_notaRepository_readAllItems() {
        let input = sut.readAllItems().count
           
        let output = sut.items.count
           
        XCTAssertEqual(output, input)
    }
    
    func test_createAndRemoveItem() {

        let input = sut.readAllItems().count
        let nota = Nota(body: "teste", cor: "azul", versos: [])
        if let notaTest = sut.createNewItem(item: nota) {
            let output = sut.readAllItems().count
            XCTAssertEqual(output, input + 1)
            _ = sut.delete(itemId: notaTest.notaId)
        }
       
        let output = sut.readAllItems().count
    
        XCTAssertEqual(output, input)
    }
    
    func test_deleteItemNill() {
        let nota = Nota(body: "teste", cor: "teste", versos: [])
        let output = sut.delete(itemId: nota.notaId)
        XCTAssertEqual(output, false)
    }
    
//    func test_createItemNill() {
//        let nota = Nota(body: nil, cor: nil)
//        let output = sut.createNewItem(item: nota)
//        XCTAssertNil(output)
//    }
    
    func test_readItem() {
        let nota = Nota(body: "teste", cor: "azul", versos: [])
        guard let notaTest = sut.createNewItem(item: nota) else { return }
        let notaRead = notaTest
        XCTAssertEqual(notaRead.notaId, notaTest.notaId)
        _ = sut.delete(itemId: notaTest.notaId)
    }
    
    func test_readItemNil() {
         
        let notaTest = Nota(body: "teste", cor: "azul", versos: [])
        let notaRead = sut.readItem(itemId: notaTest.notaId)
        XCTAssertNil(notaRead)
        
    }
        
    func test_updateItem() {
        let input = "teste_update"
        let nota = Nota(body: "teste", cor: "azul", versos: [])
        guard let notaTest = sut.createNewItem(item: nota) else {return}
        notaTest.body = input
        sut.update(item: notaTest)
        
        let output = sut.readItem(itemId: notaTest.notaId)?.body
           
        XCTAssertEqual(output, input)
        _ = sut.delete(itemId: notaTest.notaId)
    }
}
