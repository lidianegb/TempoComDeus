//
//  TestCoreDataService.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 05/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
import CoreData
@testable import tempo_com_Deus
class TestCoreDataService: XCTestCase {
    var testCoreDataStack: MockCoreDataStack!
    var context: NSManagedObjectContext!
    var sut: CoreDataService!
    
    override func setUp() {
        super.setUp()
        testCoreDataStack = MockCoreDataStack()
        context = testCoreDataStack.viewContext
        sut = CoreDataService(context)
    }
    
    func testCreateNewNote() {
        let text = "example"
        let color = Int16(1)
        let note = sut.create(text: text, color: color)
        XCTAssertNotNil(note, "Note should not nil")
        XCTAssertEqual(note.text, text, "The text in note is not correct")
        XCTAssertEqual(note.color, color, "The color in note is not correct")
    }
    
    func testFetchNotes_returnEmpty() {
        let notes = sut.fetchNotes()
        XCTAssertTrue(notes.isEmpty)
    }
    
    func testFetchNotes_returnNotEmptyNotes() {
        let _ = sut.create(text: "example", color: 1)
        let notes = sut.fetchNotes()
        XCTAssertEqual(notes.count, 1)
    }
  
    func testFetchNoteById_WhenIdInvalid_returnNil() {
        let note = sut.fetchNoteById(noteId: UUID())
        XCTAssertNil(note)
    }
    
    func testDeleteNote() {
        let note = sut.create(text: "example", color: 1)
        var notes = sut.fetchNotes()
        XCTAssertEqual(notes.count, 1)
        
        sut.delete(noteModel: note)
        notes = sut.fetchNotes()
        XCTAssertEqual(notes.count, 0)
    }

    override func tearDown() {
        self.context = nil
        self.sut = nil
        super.tearDown()
    }
}
