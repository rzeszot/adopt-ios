//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class FilterHeaderView: UICollectionReusableView {

    // MARK: -

    @IBOutlet
    var titleLabel: UILabel!

    // MARK: -

    func configure(item: FiltersModel.Group.Meta) {
        titleLabel.text = item.name
    }

}
