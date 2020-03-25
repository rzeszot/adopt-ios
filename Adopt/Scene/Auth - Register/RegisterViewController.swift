//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var dismiss: (() -> Void)!

    @IBAction
    func dismissAction() {
        dismiss()
    }

}
