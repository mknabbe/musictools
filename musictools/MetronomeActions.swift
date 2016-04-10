//
//  MetronomeActions.swift
//  musictools
//
//  Created by Martin Knabbe on 30.01.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import Foundation

/**
 The `MetronomeActions` protocol provides methods for turning the metronome on and off, as well as controlling the beat.
 
 - Since: 0.1
 */
@objc protocol MetronomeActions {

    /// Starts the metronome.
    func startPlaying()

    /// Stops the metronome.
    func stopPlaying()

    /// Indicates if a beat is playing
    var playing: Bool { get }

    /// Defines the tempo of the beat.
    var tempo: Int { get set }

    /// Defines the interval of pitched beats.
    var beat: Int { get set }
}