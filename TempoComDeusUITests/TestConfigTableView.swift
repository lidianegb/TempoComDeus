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
        let buttonTheme = tablesQuery.buttons["buttonTheme"]
        buttonTheme.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons["Modo escuro"].tap()
        sleep(1)
        buttonTheme.tap()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Padrão do sistema"]/*[[".cells.buttons[\"Padrão do sistema\"]",".buttons[\"Padrão do sistema\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        buttonTheme.tap()
        
        collectionViewsQuery.buttons["Modo claro"].tap()
        sleep(1)
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
