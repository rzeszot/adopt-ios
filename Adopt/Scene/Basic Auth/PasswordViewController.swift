//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import Combine

protocol PasswordViewControllerDelegate: class {
    func password(_ vc: PasswordViewController, didLoginWithPassword password: String)
    func passwordDidBack(_ vc: PasswordViewController)
}

class PasswordViewController: UIViewController {

    // MARK: -

    weak var delegate: PasswordViewControllerDelegate?

    // MARK: - Outlets

    @IBOutlet
    var passwordTextField: UITextField!

    @IBOutlet
    var continueButton: UIButton!

    @IBOutlet
    var bottomPadding: NSLayoutConstraint!

    @IBOutlet
    var toggleButton: UIButton!

    // MARK: -

    @IBAction
    func toggleAction() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry

        let image = UIImage(systemName: passwordTextField.isSecureTextEntry ? "eye.slash" : "eye")
        toggleButton.setImage(image, for: .normal)
    }

    @IBAction
    func backgroundTap() {
        passwordTextField.resignFirstResponder()
    }

    @IBAction
    func continueAction() {
        passwordTextField.resignFirstResponder()
        delegate?.password(self, didLoginWithPassword: passwordTextField.text ?? "")
    }

    @IBAction
    func backAction() {
        delegate?.passwordDidBack(self)
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
        passwordTextField.text = "qwerty"
        #endif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toggleAction()

        cancellable = show.merge(with: hide).sink { height in
            self.bottomPadding.constant = height

            UIView.animate(withDuration: 0.3, animations: self.view.layoutIfNeeded)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passwordTextField.resignFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        cancellable?.cancel()
        cancellable = nil
    }

    // MARK: -

    func valid(text: String) -> Bool {
        text.count >= 5
    }

}
