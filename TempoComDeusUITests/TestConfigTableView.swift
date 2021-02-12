//
//  TestConfigTableView.swift
//  ApplicationTests
//
//  Created by Lidiane Gomes Barbosa on 12/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable all

import Foundation
import XCTest
@testable import tempo_com_Deus
class TestConfigTableView: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testButtonsDarkAndLightModeConfig() {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Ajustes"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["moon"]/*[[".cells.buttons[\"moon\"]",".buttons[\"moon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["sun.max"]/*[[".cells.buttons[\"sun.max\"]",".buttons[\"sun.max\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testButtonsPlusAndMinusFontConfig() {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Ajustes"].tap()
        let tablesQuery = app.tables
        tablesQuery.buttons["buttonPlus"].tap()
        tablesQuery.buttons["buttonMinus"].tap()
    }
}
