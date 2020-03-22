//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var settings: (() -> Void)!

    @IBAction
    func settingsAction() {
        settings()
    }

}
