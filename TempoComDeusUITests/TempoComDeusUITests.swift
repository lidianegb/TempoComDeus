//
//  tempoComDeusUITests.swift
//  tempoComDeusUITests
//
//  Created by Lidiane Gomes Barbosa on 25/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//swiftlint:disable line_length
//swiftlint:disable trailing_whitespace
import XCTest
@testable import tempo_com_Deus
class TempoComDeusUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
       app.launch()
        app.navigationBars["Biblia"]/*@START_MENU_TOKEN@*/.staticTexts["Juízes 21"]/*[[".staticTexts",".buttons[\"Juízes 21\"].staticTexts[\"Juízes 21\"]",".staticTexts[\"Juízes 21\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
 
        let tablesQuery2 = app.tables
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Levítico"]/*[[".cells.staticTexts[\"Levítico\"]",".staticTexts[\"Levítico\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["16"]/*[[".cells.staticTexts[\"16\"]",".staticTexts[\"16\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Anotações"].tap()
        tabBarsQuery.buttons["Ajustes"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["sun.max"]/*[[".cells.buttons[\"sun.max\"]",".buttons[\"sun.max\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["moon"]/*[[".cells.buttons[\"moon\"]",".buttons[\"moon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
