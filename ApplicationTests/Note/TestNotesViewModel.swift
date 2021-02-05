//
//  TestNotesViewModel.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 05/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestNotesViewModel: XCTestCase {
    
    var testCoreDataStack: MockCoreDataStack!
    var service: CoreDataService!
    var sut: NotesViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        testCoreDataStack = MockCoreDataStack()
        service = CoreDataService(testCoreDataStack.viewContext)
        sut = NotesViewModel(service: service)
    }
    
    func testRestartNotes() {
        sut.restartNotes()
        XCTAssertEqual(sut.numberOfNotes(), 0)
    }
    
    func testNotesIsEmpty() {
        XCTAssertTrue(sut.isEmpty())
    }
    
    func testNoteAtIndex_isNil() {
        XCTAssertNil(sut.noteAtIndex(1))
    }
    
    func testNoteIdAtIndex_isNil() {
        XCTAssertNil(sut.noteIdAtIndex(1))
    }

    override func tearDownWithError() throws {
        super.tearDown()
        testCoreDataStack = nil
        service = nil
        sut = nil
    }

}
