//
//  tempoComDeusUITests.swift
//  tempoComDeusUITests
//
//  Created by Lidiane Gomes Barbosa on 25/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//
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
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
