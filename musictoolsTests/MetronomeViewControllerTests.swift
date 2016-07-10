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

    func testViewDidLoadShouldSetSegmentedControleProperty() {
        XCTAssertNotNil(sut.beatSegmentedControl)
    }

    func testViewControllerShouldBeDataSourceOfCollectionView() {
        XCTAssertNotNil(sut.tempoCollectionView.dataSource)
    }

    func testViewControllerShouldBeDelegateOfCollectionView() {
        XCTAssertNotNil(sut.tempoCollectionView.delegate)
    }

    func testTintColorOfSegmentedControl() {
        let expectedColor = MetronomeViewController.selectedColor
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

    func testSelectingACollectionCellShouödChangeTempoOfMetronome() {
        let metronomeStub = MetronomeStub()
        sut.metronome = metronomeStub

        let newTempo = MetronomeViewController.tempi[13]
        sut.collectionView(sut.tempoCollectionView, didSelectItemAt: IndexPath(item: 13, section: 0))

        XCTAssertEqual(metronomeStub.tempo, Int(newTempo))
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
}
