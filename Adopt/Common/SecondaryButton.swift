//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

@IBDesignable
class SecondaryButton: UIButton {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

}
