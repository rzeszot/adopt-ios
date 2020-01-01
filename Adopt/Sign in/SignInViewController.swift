//
//  SignInViewController.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit
import SwiftUI


protocol SignInViewControllerDelegate: class {
    func signIn(_ vc: SignInViewController, didLoginWith email: String, and password: String)
    func signInDidClose(_ vc: SignInViewController)
}


class SignInViewController: UIViewController {

    weak var delegate: SignInViewControllerDelegate?

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

        delegate?.signIn(self, didLoginWith: email, and: password)
    }

    @IBAction
    func closeAction() {
        delegate?.signInDidClose(self)
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
