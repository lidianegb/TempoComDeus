//
//  TestBibleUITests.swift
//  tempoComDeusUITests
//
//  Created by Lidiane Gomes Barbosa on 25/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all
import XCTest
@testable import tempo_com_Deus
class TestBibleUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testSelectChapterBible() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["titleButton"].tap()
        let tablesQuery2 = app.tables
        sleep(1)
        tablesQuery2.staticTexts["Números"].tap()
        sleep(1)
        let tablesQuery = tablesQuery2
        tablesQuery.staticTexts["16"].tap()
        
        let bibliaNavigationBar = XCUIApplication().navigationBars["Biblia"]
        bibliaNavigationBar.buttons["right"].tap()
        bibliaNavigationBar.buttons["left"].tap()
        
    }
    
    func testSelecVersionBible() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Biblia"].children(matching: .textField).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Nova Versão Internacional - NVI"]/*[[".pickers.pickerWheels[\"Nova Versão Internacional - NVI\"]",".pickerWheels[\"Nova Versão Internacional - NVI\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
    }
}
