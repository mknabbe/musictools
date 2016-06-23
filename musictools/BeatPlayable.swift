//
//  BeatPlayable.swift
//  musictools
//
//  Created by Martin Knabbe on 31.01.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import Foundation

/**
 The `BeatPlayable` protocol defines methods that allow you to produce and manage a beat.
 
 - Since: 0.1
 */
protocol BeatPlayable {

    /// Produces a single 'klick' sound.
    func playBeat()

    /// The interval of a pitched 'klick' sound.
    var alternatingBeatWithInterval: Int { get set }
}
