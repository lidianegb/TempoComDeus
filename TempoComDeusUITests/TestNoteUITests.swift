//
//  TestNoteUITests.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 12/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import XCTest
@testable import tempo_com_Deus
class TestNoteUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testNoteUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Anotações"].tap()
        app.navigationBars["Anotações"].buttons["Add"].tap()
        sleep(1)
        
        app.keys["W"].tap()
        app.keys["x"].tap()
        app.keys["y"].tap()
        app.keys["z"].tap()
       
        let salvarButton = app.buttons["Salvar"]
        salvarButton.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.staticTexts["Wxyz"].tap()
        
        app.buttons["compose"].tap()
        app.buttons["Cancelar"].tap()
        sleep(2)
        
        app.buttons["Voltar"].tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).buttons["trash"].tap()
        app.sheets.scrollViews.otherElements.buttons["Deletar"].tap()
        sleep(2)
        
    }

}
