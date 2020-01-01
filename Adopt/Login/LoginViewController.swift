//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit
import SwiftUI


protocol LoginViewControllerDelegate: class {
    func login(_ vc: LoginViewController, didLoginWith email: String, and password: String)
    func loginDidClose(_ vc: LoginViewController)
}


class LoginViewController: UIViewController {

    weak var delegate: LoginViewControllerDelegate?

    // MARK: -

    @IBOutlet
    var emailTextField: UITextField!

    @IBOutlet
    var passwordTextField: UITextField!

    // MARK: -

    @IBAction
    func loginAction() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        delegate?.login(self, didLoginWith: email, and: password)
    }

    @IBAction
    func closeAction() {
        delegate?.loginDidClose(self)
    }

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        emailTextField.text = "damian.rzeszot@gmail.com"
        passwordTextField.text = "qwerty"
        #endif
    }

}
