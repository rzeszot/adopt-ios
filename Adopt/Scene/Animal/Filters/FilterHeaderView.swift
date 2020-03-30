//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

protocol FilterHeaderViewDelegate: class {
    func filterHeaderViewDidTapClear(_ view: FilterHeaderView)
}

class FilterHeaderView: UICollectionReusableView {

    // MARK: -

    weak var delegate: FilterHeaderViewDelegate?

    // MARK: -

    @IBOutlet
    var titleLabel: UILabel!

    // MARK: -

    @IBAction
    func clearAction() {
        delegate?.filterHeaderViewDidTapClear(self)
    }

    // MARK: -

    func configure(item: Filters.Model.Group.Meta) {
        titleLabel.text = item.name
    }

}
