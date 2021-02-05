//
//  TestNoteViewModel.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 05/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestNoteViewModel: XCTestCase {
    var testCoreDataStack: MockCoreDataStack!
    var service: CoreDataService!
    var sut: NoteViewModel!
    
    override func setUp() {
        super.setUp()
        testCoreDataStack = MockCoreDataStack()
        service = CoreDataService(testCoreDataStack.viewContext)
        sut = NoteViewModel(service: service, text: "", color: 2)
    }
    
    func testInit_withNoteModel_checkAllAttributes() {
        let note = NoteModel(context: testCoreDataStack.viewContext)
        note.text = "text"
        note.color = Int16(1)
        sut = NoteViewModel(service: service, noteModel: note)
        XCTAssertNotNil(sut)
      
    }
    
    func testInit_usingId() {
        let note = NoteViewModel(service: service, noteId: sut.noteId)
        XCTAssertNotNil(note)
    }
    
    func testInit_withTextAndColor_checkAllAttributes() {
        let text = "text"
        let color = Int16(1)
        sut = NoteViewModel(service: service, text: text, color: color)

        XCTAssertNotNil(sut.noteId)
        XCTAssertNotNil(sut.text)
        XCTAssertNotNil(sut.color)
        XCTAssertNotNil(sut.date)
    }
    
    func testUpdateNote() {
        let text = "text2"
        let color = Int16(1)
        sut.updateNote(text: text, color: color)
        
        XCTAssertEqual(sut.text, text)
        XCTAssertEqual(sut.color, color)
    }
    
    override func tearDown() {
        self.testCoreDataStack = nil
        self.service = nil
        self.sut = nil
        super.tearDown()
    }
}
