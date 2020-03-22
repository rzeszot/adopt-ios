//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: -

    var login: (() -> Void)!
    var register: (() -> Void)!

    // MARK: - Actions

    @IBAction
    func loginAction() {
        login()
    }

    @IBAction
    func registerAction() {
        register()
    }

}
