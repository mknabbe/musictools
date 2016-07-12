//
//  CollectionView.swift
//  musictools
//
//  Created by Martin Knabbe on 25.06.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import UIKit

extension MetronomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MetronomeViewController.tempi.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.reuseIdentifier, for: indexPath) as? LabelCollectionViewCell else {
            fatalError("Expected to dequeue a `LabelCollectionViewCell`.")
        }

        cell.label.text = MetronomeViewController.tempi[indexPath.item]

        if indexPath.item == selectedTempoIndex {
            cell.label.textColor = MetronomeViewController.selectedColor
        } else {
            if #available(tvOS 10.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    cell.label.textColor = UIColor.lightGray()
                } else {
                    cell.label.textColor = UIColor.darkGray()
                }
            } else {
                cell.label.textColor = UIColor.darkGray()
            }
        }

        return cell
    }
}

extension MetronomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tempo = Int(MetronomeViewController.tempi[indexPath.row]) else { return }
        metronome.tempo = tempo
        let oldSelectedIndexPath = IndexPath(item: selectedTempoIndex, section: 0)
        selectedTempoIndex = indexPath.item
        collectionView.reloadItems(at: [indexPath, oldSelectedIndexPath])
    }
}
