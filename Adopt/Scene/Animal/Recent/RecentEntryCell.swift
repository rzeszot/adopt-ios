//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

@IBDesignable
class RecentEntryCell: UICollectionViewCell {

    // MARK: -

    @IBOutlet
    var titleLabel: UILabel!

    @IBOutlet
    var subtitleLabel: UILabel!

    @IBOutlet
    var imageView: UIImageView!

    // MARK: -

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        contentView.layer.cornerRadius = 10

        layer.cornerRadius = 10
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = .zero
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.shadowColor = UIColor.secondaryLabel.cgColor
    }

    // MARK: -

    func configure(image: UIImage?) {
        imageView.image = image
    }

}
