//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit
import Combine

protocol LoginViewControllerDelegate: class {
    func login(_ vc: LoginViewController, didLoginWithEmail email: String)
    func loginDidClose(_ vc: LoginViewController)
    func loginDidTapRegister(_ vc: LoginViewController)
}

class LoginViewController: UIViewController {

    // MARK: -

    weak var delegate: LoginViewControllerDelegate?

    // MARK: -

    @IBOutlet
    var emailTextField: UITextField!

    @IBOutlet
    var continueButton: UIButton!

    @IBOutlet
    var bottomPadding: NSLayoutConstraint!

    // MARK: -

    @IBAction
    func continueAction() {
        let text = emailTextField.text ?? ""

        if text.count >= 5 {
            emailTextField.resignFirstResponder()
            delegate?.login(self, didLoginWithEmail: text)
        } else {
            emailTextField.shake()
        }
    }

    @IBAction
    func closeAction() {
        delegate?.loginDidClose(self)
    }

    @IBAction
    func registerAction() {
        emailTextField.resignFirstResponder()
        delegate?.loginDidTapRegister(self)
    }

    @IBAction
    func backgroundTap() {
        emailTextField.resignFirstResponder()
    }

    // MARK: -

    private let show = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
        .map { $0.cgRectValue.height }

    private let hide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat(0) }

    private var cancellable: AnyCancellable?

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        emailTextField.text = "damian.rzeszot@gmail.com"
        #endif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cancellable = show.merge(with: hide).sink { height in
            self.bottomPadding.constant = height

            UIView.animate(withDuration: 0.3, animations: self.view.layoutIfNeeded)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.resignFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        cancellable?.cancel()
        cancellable = nil
    }
}

extension UIView {
    func shake() {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translation.timingFunction = CAMediaTimingFunction(name: .linear)
        translation.values = [-10, 10, -10, 10, -5, 5, -2, 2, 0]
        translation.duration = 0.6
        layer.add(translation, forKey: nil)
    }
}
