//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

protocol SearchHeaderViewDelegate: class {
    func searchHeaderViewDidTapClean(_ view: SearchHeaderView)
}

class SearchHeaderView: UICollectionReusableView {

    // MARK: -

    weak var delegate: SearchHeaderViewDelegate?

    // MARK: - Outlet

    @IBOutlet
    var titleLabel: UILabel!

    // MARK: -

    @IBAction
    func clearAction() {
        delegate?.searchHeaderViewDidTapClean(self)
    }

}
