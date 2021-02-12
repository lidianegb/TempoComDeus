//
//  tempoComDeusUITests.swift
//  tempoComDeusUITests
//
//  Created by Lidiane Gomes Barbosa on 25/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class TempoComDeusUITests: XCTestCase {

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
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Levítico"]/*[[".cells.staticTexts[\"Levítico\"]",".staticTexts[\"Levítico\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["16"]/*[[".cells.staticTexts[\"16\"]",".staticTexts[\"16\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
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

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric.init()]) {
                XCUIApplication().launch()
            }
        }
    }
}
