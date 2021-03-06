//
//  LabelCollectionViewCell.swift
//  musictools
//
//  Created by Martin Knabbe on 26.06.16.
//  Copyright © 2016 Martin Knabbe. All rights reserved.
//

import UIKit

/**
 The `LabelCollectionViewCell` class contains a background image and a label to display the content.

 - Since: 0.1
 */
class LabelCollectionViewCell : UICollectionViewCell {

    static let reuseIdentifier = "LabelCollectionViewCell"

    /// Contains the background image
    @IBOutlet weak var imageView: UIImageView!

    /// Contains the tempo digits
    @IBOutlet weak var label: UILabel!

    override var accessibilityLabel: String? {
        get {
            return label.text
        }
        set {
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(tvOS 10.0, *) {
            guard(traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle)
                else { return }

            if traitCollection.userInterfaceStyle == .dark {
                label.textColor = UIColor.lightGray()
            } else {
                label.textColor = UIColor.darkGray()
            }
        }
    }
}
