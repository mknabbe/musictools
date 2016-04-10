//
//  ViewController.swift
//  musictools
//
//  Created by Martin Knabbe on 30.01.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import UIKit

/**
 The `MetronomeViewController` class mediates between the UI elements and the `Metronome` instance.
 
 - Since: 0.1
 */
final class MetronomeViewController: UIViewController {

    // MARK: - Properties

    static let SelectedColor = UIColor(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)

    @IBOutlet var beatButtons: [UIButton]!
    @IBOutlet var tempoButtons: [UIButton]!

    @IBOutlet var metronome: MetronomeActions!

    // from visual top to bottom
    private var focusGuide0: UIFocusGuide!
    private var focusGuide1: UIFocusGuide!
    private var focusGuide2: UIFocusGuide!

    /**
     Searches for a button with the given title in a given array.

     - parameter title: The button title to search for.
     - parameter buttons: The button collection.
     - returns: The first button with the given `title` in `buttons` or nil if no button was found.
     - Complexity: O(n)
     */
    static func buttonWithTitle(title: String, inArray buttons: [UIButton]) -> UIButton? {
        for button in buttons where button.titleForState(.Normal) == title {
            return button
        }

        return nil
    }

    // MARK: - Instance methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFocusGuides()
        setupTitleColorOfInitiallySelectedButtons()
    }

    private func setupFocusGuides() {
        setupFocusGuide0()
        setupFocusGuide1()
        setupFocusGuide2()
    }

    private func setupFocusGuide0() {
        guard let beat6Button = MetronomeViewController.buttonWithTitle("6", inArray: beatButtons) else { return }
        guard let tempo50Button = MetronomeViewController.buttonWithTitle("50", inArray: tempoButtons) else { return }

        focusGuide0 = UIFocusGuide()
        setupFocusGuide(focusGuide0, withFirstButton: tempo50Button, andSecondButton: beat6Button)
    }

    private func setupFocusGuide1() {
        guard let tempo50Button = MetronomeViewController.buttonWithTitle("50", inArray: tempoButtons) else { return }
        guard let tempo76Button = MetronomeViewController.buttonWithTitle("76", inArray: tempoButtons) else { return }

        focusGuide1 = UIFocusGuide()
        setupFocusGuide(focusGuide1, withFirstButton: tempo50Button, andSecondButton: tempo76Button)
    }

    private func setupFocusGuide2() {
        guard let tempo112Button = MetronomeViewController.buttonWithTitle("112", inArray: tempoButtons) else { return }
        guard let tempo168Button = MetronomeViewController.buttonWithTitle("168", inArray: tempoButtons) else { return }

        focusGuide2 = UIFocusGuide()
        setupFocusGuide(focusGuide2, withFirstButton: tempo112Button, andSecondButton: tempo168Button)
    }

    private func setupFocusGuide(focusGuide: UIFocusGuide, withFirstButton firstButton: UIButton, andSecondButton secondButton: UIButton) {
        view.addLayoutGuide(focusGuide)

        focusGuide.leftAnchor.constraintEqualToAnchor(firstButton.leftAnchor).active = true
        focusGuide.bottomAnchor.constraintEqualToAnchor(secondButton.bottomAnchor).active = true
        focusGuide.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        focusGuide.heightAnchor.constraintEqualToAnchor(secondButton.heightAnchor).active = true
    }

    private func setupTitleColorOfInitiallySelectedButtons() {
        let initiallySelectedBeatButton = MetronomeViewController.buttonWithTitle(String(metronome.beat), inArray: beatButtons)
        initiallySelectedBeatButton?.setTitleColor(MetronomeViewController.SelectedColor, forState: .Normal)
        initiallySelectedBeatButton?.setTitleColor(MetronomeViewController.SelectedColor, forState: .Focused)

        let initiallySelectedTempoButton = MetronomeViewController.buttonWithTitle(String(metronome.tempo), inArray: tempoButtons)
        initiallySelectedTempoButton?.setTitleColor(MetronomeViewController.SelectedColor, forState: .Normal)
        initiallySelectedTempoButton?.setTitleColor(MetronomeViewController.SelectedColor, forState: .Focused)
    }

    // MARK: UIFocusEnvironment

    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)

        /*
            Update the focus guide's `preferredFocusedView` depending on which
            button has the focus.
        */
        guard let nextFocusedButton = context.nextFocusedView as? UIButton else { return }
        guard let buttonTitle = nextFocusedButton.titleForState(.Normal) else { return }

        switch buttonTitle {
        case "6":
            if let tempo50Button = MetronomeViewController.buttonWithTitle("50", inArray: tempoButtons) {
                focusGuide0.preferredFocusedView = tempo50Button
            }

        case "50", "52", "54", "56", "58":
            if let beat6Button = MetronomeViewController.buttonWithTitle("6", inArray: beatButtons) {
                focusGuide0.preferredFocusedView = beat6Button
            }

            if let tempo76Button = MetronomeViewController.buttonWithTitle("76", inArray: tempoButtons) {
                focusGuide1.preferredFocusedView = tempo76Button
            }

        case "76":
            if let tempo100Button = MetronomeViewController.buttonWithTitle("100", inArray: tempoButtons) {
                focusGuide1.preferredFocusedView = tempo100Button
            }

        case "100", "104", "108", "112", "116", "120":
            if let tempo76Button = MetronomeViewController.buttonWithTitle("76", inArray: tempoButtons) {
                focusGuide1.preferredFocusedView = tempo76Button
            }

            if let tempo168Button = MetronomeViewController.buttonWithTitle("168", inArray: tempoButtons) {
                focusGuide2.preferredFocusedView = tempo168Button
            }

        case "168":
            if let tempo108Button = MetronomeViewController.buttonWithTitle("208", inArray: tempoButtons) {
                focusGuide2.preferredFocusedView = tempo108Button
            }
            

        default:
            focusGuide0.preferredFocusedView = nil
            focusGuide1.preferredFocusedView = nil
            focusGuide2.preferredFocusedView = nil
        }
    }

    // MARK: - Actions

    @IBAction func pressedPlayPause(_: UITapGestureRecognizer) {
        if metronome.playing {
            metronome.stopPlaying()
        } else {
            metronome.startPlaying()
        }
    }

    @IBAction func changeBeat(sender: UIButton) {
        if let previosulySelectedBeatButton = MetronomeViewController.buttonWithTitle(String(metronome.beat), inArray: beatButtons) {
            previosulySelectedBeatButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            previosulySelectedBeatButton.setTitleColor(UIColor.blackColor(), forState: .Focused)
        }

        guard let title = sender.titleForState(.Normal) else { return }
        metronome.beat = Int(title) ?? Metronome.DefaultBeat

        sender.setTitleColor(MetronomeViewController.SelectedColor, forState: .Normal)
        sender.setTitleColor(MetronomeViewController.SelectedColor, forState: .Focused)
    }

    @IBAction func changeTempo(sender: UIButton) {
        if let previosulySelectedTempoButton = MetronomeViewController.buttonWithTitle(String(metronome.tempo), inArray: tempoButtons) {
            previosulySelectedTempoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            previosulySelectedTempoButton.setTitleColor(UIColor.blackColor(), forState: .Focused)
        }

        guard let title = sender.titleForState(.Normal) else { return }
        metronome.tempo = Int(title) ?? Metronome.DefaultTempo

        sender.setTitleColor(MetronomeViewController.SelectedColor, forState: .Normal)
        sender.setTitleColor(MetronomeViewController.SelectedColor, forState: .Focused)
    }
}