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

    static let selectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    static let names = [ "Largo", "Larghetto", "Adagio", "Andante",
                         "Moderato", "Allegro", "Presto", "Prestissimo" ]
    static let tempi = [ "40", "42", "44", "46", "48", "50", "52", "54", "56", "58", "63", "66",
                         "69", "72", "76", "80", "84", "88", "92", "96", "100", "104", "108", "112",
                         "116", "120", "126", "132", "138", "144", "152", "160", "168", "176",
                         "184", "192", "200", "208"]

    @IBOutlet var tempoButtons: [UIButton]!
    @IBOutlet weak var beatSegmentedControl: UISegmentedControl!

    @IBOutlet var tempoCollectionView: UICollectionView!
    @IBOutlet var metronome: MetronomeActions!

    var selectedTempoIndex = 0

    private let focusGuide = UIFocusGuide()

    // MARK: - Instance methods

    override func viewDidLoad() {
        super.viewDidLoad()

        beatSegmentedControl.tintColor = MetronomeViewController.selectedColor
        setInitialColorOfSelectedBeatSegment()
        updateSelectedTempoIndex()
        setupFocusGuide()
    }

    private func setInitialColorOfSelectedBeatSegment() {
        let beat = String(metronome.beat)

        for i in 0..<beatSegmentedControl.numberOfSegments {
            if beatSegmentedControl.titleForSegment(at: i) == beat {
                beatSegmentedControl.selectedSegmentIndex = i
                break
            }
        }
    }

    private func updateSelectedTempoIndex() {
        guard let index = MetronomeViewController.tempi.index(of: "\(metronome.tempo)") else { return }
        selectedTempoIndex = index
    }

    private func setupFocusGuide() {
        view.addLayoutGuide(focusGuide)

        focusGuide.leftAnchor.constraint(equalTo: beatSegmentedControl.rightAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: tempoCollectionView.topAnchor).isActive = true
        focusGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        focusGuide.topAnchor.constraint(equalTo: beatSegmentedControl.topAnchor).isActive = true

        focusGuide.preferredFocusedView = beatSegmentedControl
    }

    // MARK: UIFocusEnvironment

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        /*
            Update the focus guide's `preferredFocusedView` depending on which
            view has the focus.
        */
        if let _ = context.nextFocusedView as? UICollectionViewCell {
            focusGuide.preferredFocusedView = beatSegmentedControl
        } else {
            focusGuide.preferredFocusedView = tempoCollectionView
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
}
