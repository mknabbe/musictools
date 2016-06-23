//
//  musictoolsUITests.swift
//  musictoolsUITests
//
//  Created by Martin Knabbe on 30.01.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import XCTest

class musictoolsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    // MARK: - Focus guide tests

    func testFirstRowShouldMoveFocusToSecondRowAtEndOfRow() {
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)

        let expectedButton = XCUIApplication().buttons["50"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testThirdRowShouldMoveFocusToFourthRowAtEndOfRow() {
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)

        let expectedButton = XCUIApplication().buttons["100"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testFithRowShouldMoveFocusToSixthRowAtEndOfROw() {
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)

        let expectedButton = XCUIApplication().buttons["208"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testSecondRowShouldMoveFocusToThirdRowWhenNavigatingDown() {
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.down)

        let expectedButton = XCUIApplication().buttons["76"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testFourthRowShouldMoveFocusToFithRowWhenNavigatingDown() {
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.down)

        let expectedButton = XCUIApplication().buttons["168"]
        XCTAssertTrue(expectedButton.hasFocus)
    }
}
