//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class ForgetViewController: UIViewController {

    var dismiss: (() -> Void)!

    @IBAction
    func dismissAction() {
        dismiss()
    }

}
