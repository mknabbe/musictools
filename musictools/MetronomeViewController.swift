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

    static let SelectedColor = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)

    @IBOutlet var tempoButtons: [UIButton]!
    @IBOutlet weak var beatSegmentedControl: UISegmentedControl!

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
    static func buttonWithTitle(_ title: String, inArray buttons: [UIButton]) -> UIButton? {
        for button in buttons where button.title(for: UIControlState()) == title {
            return button
        }

        return nil
    }

    // MARK: - Instance methods

    override func viewDidLoad() {
        super.viewDidLoad()

        beatSegmentedControl.tintColor = MetronomeViewController.SelectedColor
        setupFocusGuides()
        setupTitleColorOfInitiallySelectedButtons()
    }

    private func setupFocusGuides() {
        setupFocusGuide0()
        setupFocusGuide1()
        setupFocusGuide2()
    }

    private func setupFocusGuide0() {
        guard let tempo50Button = MetronomeViewController.buttonWithTitle("50", inArray: tempoButtons) else { return }

        focusGuide0 = UIFocusGuide()
        view.addLayoutGuide(focusGuide0)

        focusGuide0.leftAnchor.constraint(equalTo: tempo50Button.leftAnchor).isActive = true
        focusGuide0.bottomAnchor.constraint(equalTo: beatSegmentedControl.bottomAnchor).isActive = true
        focusGuide0.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        focusGuide0.heightAnchor.constraint(equalTo: beatSegmentedControl.heightAnchor).isActive = true
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

    private func setupFocusGuide(_ focusGuide: UIFocusGuide, withFirstButton firstButton: UIButton, andSecondButton secondButton: UIButton) {
        view.addLayoutGuide(focusGuide)

        focusGuide.leftAnchor.constraint(equalTo: firstButton.leftAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: secondButton.bottomAnchor).isActive = true
        focusGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: secondButton.heightAnchor).isActive = true
    }

    private func setupTitleColorOfInitiallySelectedButtons() {
        let initiallySelectedTempoButton = MetronomeViewController.buttonWithTitle(String(metronome.tempo), inArray: tempoButtons)
        initiallySelectedTempoButton?.setTitleColor(MetronomeViewController.SelectedColor, for: UIControlState())
        initiallySelectedTempoButton?.setTitleColor(MetronomeViewController.SelectedColor, for: .focused)
    }

    // MARK: UIFocusEnvironment

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        /*
            Update the focus guide's `preferredFocusedView` depending on which
            button has the focus.
        */
        guard let nextFocusedButton = context.nextFocusedView as? UIButton else {
            if let tempo50Button = MetronomeViewController.buttonWithTitle("50", inArray: tempoButtons) {
                focusGuide0.preferredFocusedView = tempo50Button
            }
            return
        }
        guard let buttonTitle = nextFocusedButton.title(for: UIControlState()) else { return }

        switch buttonTitle {
        case "50", "52", "54", "56", "58":
            focusGuide0.preferredFocusedView = beatSegmentedControl

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

    @IBAction func changeBeat(_ sender: UISegmentedControl) {
        guard let title = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
        metronome.beat = Int(title) ?? Metronome.DefaultBeat
    }

    @IBAction func changeTempo(_ sender: UIButton) {
        if let previosulySelectedTempoButton = MetronomeViewController.buttonWithTitle(String(metronome.tempo), inArray: tempoButtons) {
            previosulySelectedTempoButton.setTitleColor(UIColor.white(), for: UIControlState())
            previosulySelectedTempoButton.setTitleColor(UIColor.black(), for: .focused)
        }

        guard let title = sender.title(for: UIControlState()) else { return }
        metronome.tempo = Int(title) ?? Metronome.DefaultTempo

        sender.setTitleColor(MetronomeViewController.SelectedColor, for: UIControlState())
        sender.setTitleColor(MetronomeViewController.SelectedColor, for: .focused)
    }
}
