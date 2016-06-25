//
//  MetronomeViewControllerTests.swift
//  musictools
//
//  Created by Martin Knabbe on 08.04.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import XCTest
@testable import musictools

class MetronomeViewControllerTests: XCTestCase {

    private var sut: MetronomeViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateInitialViewController() as! MetronomeViewController
        let _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewDidLoadShouldSetMetronomeProperty() {
        XCTAssertNotNil(sut.metronome)
    }

    func testViewDidLoadShouldSetTitleColorOfSelectedTempoButton() {
        guard let tempoButton = MetronomeViewController.buttonWithTitle("63", inArray: sut.tempoButtons) else { XCTFail(); return; }
        let expectedColor = MetronomeViewController.SelectedColor
        XCTAssertEqual(tempoButton.titleColor(for: UIControlState()), expectedColor)
        XCTAssertEqual(tempoButton.titleColor(for: .focused), expectedColor)
    }

    func testTintColorOfSegmentedControl() {
        let expectedColor = MetronomeViewController.SelectedColor
        XCTAssertEqual(sut.beatSegmentedControl.tintColor, expectedColor)
    }

    func testChangeBeatShouldSetBeatOfMetronome() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let segmentedControl = UISegmentedControl(items: ["3"])
        segmentedControl.selectedSegmentIndex = 0
        sut.changeBeat(segmentedControl)

        XCTAssertEqual(metronomeStub.beat, 3)
    }

    func testChangeTempoShouldSetTempoOfMetronome() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let button = UIButton()
        button.setTitle("73", for: UIControlState())

        sut.changeTempo(button)

        XCTAssertEqual(metronomeStub.tempo, 73)
    }

    func testChangeTempoShouldChangeTitleColorOfSelectedButton() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let button = UIButton()
        button.setTitle("73", for: UIControlState())

        sut.changeTempo(button)

        let expectedColor = MetronomeViewController.SelectedColor
        XCTAssertEqual(button.titleColor(for: UIControlState()), expectedColor)
        XCTAssertEqual(button.titleColor(for: .focused), expectedColor)
    }

    func testPressedPlayPauseShouldToggleMetronomePlayState() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let tapGestureRecognizer = UITapGestureRecognizer()
        sut.pressedPlayPause(tapGestureRecognizer)
        XCTAssertTrue(metronomeStub.playing)

        sut.pressedPlayPause(tapGestureRecognizer)
        XCTAssertFalse(metronomeStub.playing)
    }

    func testUpdateFocusPerformance() {
        let context = FocusUpdateStub()
        let animationCoordinator = UIFocusAnimationCoordinator()

        measure() {
            self.sut.didUpdateFocus(in: context, with: animationCoordinator)
        }
    }

    class MetronomeStub: NSObject, MetronomeActions {
        var didCallStartPlaying = false
        var didCallStopPlaying = false

        func startPlaying() {
            playing = true
        }

        func stopPlaying() {
            playing = false
        }

        var playing = false

        var tempo = 0

        var beat = 0
    }

    class FocusUpdateStub: UIFocusUpdateContext {

        override weak var nextFocusedView: UIView? {
            get {
                let button = UIButton()
                button.setTitle("168", for: UIControlState())
                return button
            }
        }
    }
}
