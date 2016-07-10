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

    func testFocusGuideShouldNavigateToCollectionView() {
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)

        let expectedView = XCUIApplication().collectionViews.element.cells["40"]
        XCTAssertTrue(expectedView.hasFocus)
    }

    func testFocusGuideShouldNavigateToSegmentedControl() {
        XCUIRemote.shared().press(.down)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.right)
        XCUIRemote.shared().press(.up)

        let expectedButton = XCUIApplication().segmentedControls.element.buttons["0"]
        XCTAssertTrue(expectedButton.hasFocus)
    }
}
