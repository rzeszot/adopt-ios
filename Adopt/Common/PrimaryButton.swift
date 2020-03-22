//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1)
        contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layer.cornerRadius = 5
    }

}
