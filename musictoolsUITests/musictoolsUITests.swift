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
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)

        let expectedButton = XCUIApplication().buttons["50"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testThirdRowShouldMoveFocusToFourthRowAtEndOfRow() {
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)

        let expectedButton = XCUIApplication().buttons["100"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testFithRowShouldMoveFocusToSixthRowAtEndOfROw() {
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)

        let expectedButton = XCUIApplication().buttons["208"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testSecondRowShouldMoveFocusToThirdRowWhenNavigatingDown() {
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Down)

        let expectedButton = XCUIApplication().buttons["76"]
        XCTAssertTrue(expectedButton.hasFocus)
    }

    func testFourthRowShouldMoveFocusToFithRowWhenNavigatingDown() {
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Down)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Right)
        XCUIRemote.sharedRemote().pressButton(.Down)

        let expectedButton = XCUIApplication().buttons["168"]
        XCTAssertTrue(expectedButton.hasFocus)
    }
}
