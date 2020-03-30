//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class FilterItemCell: UICollectionViewCell {

    // MARK: -

    @IBOutlet
    var titleLabel: UILabel!

    // MARK: -

    func configure(item: Filters.Model.Group.Item) {
        titleLabel.text = item.name
    }

    // MARK: -

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? tintColor : .secondarySystemBackground
            titleLabel.textColor = isSelected ? .white : .label
        }
    }

}
