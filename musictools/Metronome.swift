//
//  Metronom.swift
//  musictools
//
//  Created by Martin Knabbe on 30.01.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import Foundation

/**
 The `Metronome` class provides the functionality of a metronome. It uses a `BeatPlayer` instance
 to produce the beat.
 
 - Since: 0.1
 */
final class Metronome: NSObject, MetronomeActions {

    static let DefaultTempo = 63
    static let MinimumTempo = 40
    static let MaximumTempo = 208

    static let DefaultBeat = 0
    static let MinimumBeat = 0
    static let MaximumBeat = 6

    @IBOutlet var beatPlayer: BeatPlayer?

    /// Timer calling beatPlayer to play 'klick' sound.
    private weak var soundTimer: Timer?

    private(set) var playing = false

    private var _tempo = DefaultTempo
    var tempo: Int {
        get {
            return _tempo
        }
        set {
            _tempo = min(max(newValue, Metronome.MinimumTempo), Metronome.MaximumTempo)

            if playing {
                startTimerWithBeatsPerSecond(_tempo)
            }
        }
    }

    private var _beat = DefaultBeat
    var beat: Int {
        get {
            return _beat
        }
        set {
            if (newValue == 1) {
                _beat = Metronome.MinimumBeat
            } else {
                _beat = min(max(newValue, Metronome.MinimumBeat), Metronome.MaximumBeat)
            }

            beatPlayer?.alternatingBeatWithInterval = _beat
        }
    }

    func startPlaying() {
        playing = true
        beatPlayer?.initOpenAL()
        startTimerWithBeatsPerSecond(tempo)
    }

    func stopPlaying() {
        soundTimer?.invalidate()
        soundTimer = nil
        playing = false
    }

    private func startTimerWithBeatsPerSecond(_ beatsPerSecond: Int) {
        guard let beatPlayer = beatPlayer else { return }

        let intervalInSeconds = 60.0 / TimeInterval(beatsPerSecond)
        soundTimer?.invalidate()
        soundTimer = Timer.scheduledTimer(timeInterval: intervalInSeconds, target: beatPlayer, selector: Selector(("playBeat")), userInfo: nil, repeats: true)
    }
}
