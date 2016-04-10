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

    func testViewDidLoadShouldSetTitleColorOfSelectedBeatButton() {
        guard let beatButton = MetronomeViewController.buttonWithTitle("0", inArray: sut.beatButtons) else { XCTFail(); return; }
        let expectedColor = UIColor(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        XCTAssertEqual(beatButton.titleColorForState(.Normal), expectedColor)
        XCTAssertEqual(beatButton.titleColorForState(.Focused), expectedColor)
    }

    func testViewDidLoadShouldSetTitleColorOfSelectedTempoButton() {
        guard let tempoButton = MetronomeViewController.buttonWithTitle("63", inArray: sut.tempoButtons) else { XCTFail(); return; }
        let expectedColor = UIColor(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        XCTAssertEqual(tempoButton.titleColorForState(.Normal), expectedColor)
        XCTAssertEqual(tempoButton.titleColorForState(.Focused), expectedColor)
    }

    func testChangeBeatShouldSetBeatOfMetronome() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let button = UIButton()
        button.setTitle("3", forState: .Normal)
        sut.changeBeat(button)

        XCTAssertEqual(metronomeStub.beat, 3)
    }

    func testChangeBeatShouldChangeTitleColorOfSelectedButton() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let button = UIButton()
        button.setTitle("3", forState: .Normal)

        sut.changeBeat(button)

        let expectedColor = UIColor(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        XCTAssertEqual(button.titleColorForState(.Normal), expectedColor)
        XCTAssertEqual(button.titleColorForState(.Focused), expectedColor)
    }

    func testChangeTempoShouldSetTempoOfMetronome() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let button = UIButton()
        button.setTitle("73", forState: .Normal)

        sut.changeTempo(button)

        XCTAssertEqual(metronomeStub.tempo, 73)
    }

    func testChangeTempoShouldChangeTitleColorOfSelectedButton() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let button = UIButton()
        button.setTitle("73", forState: .Normal)

        sut.changeTempo(button)

        let expectedColor = UIColor(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        XCTAssertEqual(button.titleColorForState(.Normal), expectedColor)
        XCTAssertEqual(button.titleColorForState(.Focused), expectedColor)
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

        measureBlock() {
            self.sut.didUpdateFocusInContext(context, withAnimationCoordinator: animationCoordinator)
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
                button.setTitle("168", forState: .Normal)
                return button
            }
        }
    }
}
