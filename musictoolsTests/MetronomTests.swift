//
//  MetronomTests.swift
//  musictools
//
//  Created by Martin Knabbe on 30.01.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import XCTest
@testable import musictools

class MetronomTests: XCTestCase {

    private var sut: Metronome!

    override func setUp() {
        super.setUp()
        sut = Metronome()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testMetronomeNotRunningAfterInitialization() {
        XCTAssertFalse(sut.playing)
    }

    func testStartingMetronome() {
        sut.startPlaying()

        XCTAssertTrue(sut.playing)
    }

    func testStoppingMetronome() {
        sut.startPlaying()
        sut.stopPlaying()

        XCTAssertFalse(sut.playing)
    }

    func testInitialTempoShouldBe63BeatsPerMinute() {
        XCTAssertEqual(sut.tempo, 63)
    }

    func testSetTempoTo75() {
        let tempo = 75
        sut.tempo = tempo

        XCTAssertEqual(sut.tempo, tempo)
    }

    func testSetTempoBelowMinimumTempoShouldSetTempoToMinimumTempo() {
        sut.tempo = 2

        XCTAssertEqual(sut.tempo, 40)
    }

    func testSetTempoAboveMaximumTempoShouldSetTempoToMaximumTempo() {
        sut.tempo = 10000

        XCTAssertEqual(sut.tempo, 208)
    }

    func testInitialBeatShouldBe0() {
        XCTAssertEqual(sut.beat, 0)
    }

    func testSetBeatTo5() {
        let beat = 5
        sut.beat = beat

        XCTAssertEqual(sut.beat, beat)
    }

    func testSetBeatTo1ShouldSetBeatToMinimumBeat() {
        sut.beat = 1

        XCTAssertEqual(sut.beat, 0)
    }

    func testSetBeatBelowMinimumBeatShouldSetBeatToMinimumBeat() {
        sut.beat = -1

        XCTAssertEqual(sut.beat, 0)
    }

    func testSetBeatAboveMaximumBeatShouldSetBeatToMaximumBeat() {
        sut.beat = 10

        XCTAssertEqual(sut.beat, 6)
    }
}
