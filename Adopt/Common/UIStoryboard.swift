//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

// swiftlint:disable force_cast

import UIKit

extension UIStoryboard {

    static func instantiate<T: UIViewController>(name: String = "Main", identifier: String) -> T {
        UIStoryboard(name: name, bundle: nil).instantiateViewController(identifier: identifier) as! T
    }

}
