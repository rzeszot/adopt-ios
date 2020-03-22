//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var profile: (() -> Void)!

    @IBAction
    func profileAction() {
        profile()
    }

}
