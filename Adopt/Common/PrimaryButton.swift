//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {

    override func didMoveToWindow() {
        super.didMoveToWindow()

        contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layer.cornerRadius = 5
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()

        tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundColor = window?.tintColor ?? tintColor
    }

}
