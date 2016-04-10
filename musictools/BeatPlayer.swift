//
//  BeatPlayer.swift
//  musictools
//
//  Created by Martin Knabbe on 31.01.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import Foundation
import UIKit
import OpenAL

/**
 The `BeatPlayer` class implements the interface between Swift classes and OpenAL framework to generate a beat.
 
 - Since: 0.1
 */
final class BeatPlayer: NSObject, BeatPlayable {

    static let DefaultDistance: ALfloat = 25.0
    static let DefaultPitch: ALfloat = 1.0
    static let Pitch: ALfloat = 1.3
    static let SourceReferenceDistance: ALfloat = 50.0

    var alternatingBeatWithInterval = 0 {
        willSet(interval) {
            if (interval == 0) {
                pitchEnabled = false
                alSourcef(source, AL_PITCH, BeatPlayer.DefaultPitch)
                alGetError()
            } else {
                pitchEnabled = true
            }
        }
    }

    private var source: ALuint = 0
    private var buffer: ALuint = 0
    private var context: COpaquePointer = nil // ALCcontext
    private var device: COpaquePointer = nil  // ALCdevice

    // Start with our sound source slightly in front of the listener
    private let sourcePositionX: ALfloat = 0.0
    private let sourcePositionY: ALfloat = -70.0

    private var openALInitialized = false

    private var pitchEnabled = false
    private var intervalCounter = 0

    func initOpenAL() {
        if !openALInitialized {
            var error: ALenum

            device = alcOpenDevice(nil);
            if device != nil {
                var attrlist: ALCint = 0
                context = alcCreateContext(device, &attrlist)

                if context != nil {
                    alcMakeContextCurrent(context)

                    alGenBuffers(1, &buffer);
                    error = alGetError()
                    if error != AL_NO_ERROR {
                            NSLog("Error Generating Buffers: %x", error)
                            exit(1)
                    }

                    alGenSources(1, &source);
                    error = alGetError()
                    if error != AL_NO_ERROR {
                        NSLog("Error generating sources! %x\n", error)
                        exit(1)
                    }
                }
            }

            alGetError();

            initBuffer()
            initSource()
            openALInitialized = true
        }
    }

    private func initBuffer() {
        var error: ALenum = AL_NO_ERROR
        var format: ALenum = 0
        var size: ALsizei = 0
        var freq: ALsizei = 0

        let bundle = NSBundle.mainBundle()
        guard let path = bundle.pathForResource("sound", ofType: "m4a") else { NSLog("Could not find file!\n"); return }
        let fileURL = NSURL.fileURLWithPath(path, isDirectory: false)

        let data: UnsafeMutablePointer<Void> = MyGetOpenALAudioData(fileURL, &size, &format, &freq)

        error = alGetError()
        if error != AL_NO_ERROR {
            NSLog("error loading sound: %x\n", error)
            exit(1);
        }

        // use the static buffer data API
        alBufferDataStaticProc(ALint(buffer), format, data, size, freq)

        error = alGetError()
        if error != AL_NO_ERROR {
            NSLog("error attaching audio to buffer: %x\n", error)
        }
    }

    private func initSource() {
        var error: ALenum = AL_NO_ERROR
        alGetError(); // Clear the error

        // Set Source Position
        let sourcePosAL: [ALfloat] = [sourcePositionX, BeatPlayer.DefaultDistance, sourcePositionY]
        alSourcefv(source, AL_POSITION, sourcePosAL)

        // Set Source Reference Distance
        alSourcef(source, AL_REFERENCE_DISTANCE, BeatPlayer.SourceReferenceDistance)

        // attach OpenAL Buffer to OpenAL Source
        alSourcei(source, AL_BUFFER, ALint(buffer))

        error = alGetError()
        if error != AL_NO_ERROR {
            NSLog("Error attaching buffer to source: %x\n", error)
            exit(1);
        }
    }

    func teardownOpenAL() {
        alDeleteSources(1, &source)
        alDeleteBuffers(1, &buffer)
        alcDestroyContext(context)
        alcCloseDevice(device)
        openALInitialized = false
    }

    func playBeat() {
        if pitchEnabled {
            if (intervalCounter >= alternatingBeatWithInterval) {
                intervalCounter = 0
                alSourcef(source, AL_PITCH, BeatPlayer.Pitch)
            } else {
                alSourcef(source, AL_PITCH, BeatPlayer.DefaultPitch)
                intervalCounter += 1
            }

            alGetError()
        }
        
        alSourcePlay(source)
    }
}