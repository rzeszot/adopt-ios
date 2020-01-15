//
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import UIKit
import SwiftUI
import Combine


protocol LoginViewControllerDelegate: class {
    func login(_ vc: LoginViewController, didLoginWith email: String, and password: String)
    func loginDidClose(_ vc: LoginViewController)
    func loginDidTapRegister(_ vc: LoginViewController)
}


class LoginViewController: UIViewController {

    weak var delegate: LoginViewControllerDelegate?

    // MARK: -

    @IBOutlet
    var emailTextField: UITextField!
    
    @IBOutlet
    var placeholderLabel: UILabel!
    
    @IBOutlet
    var continueButton: UIButton!
    
    @IBOutlet
    var bottomPadding: NSLayoutConstraint!

    // MARK: -

    @IBAction
    func continueAction() {
        emailTextField.resignFirstResponder()
    }

    @IBAction
    func closeAction() {
        delegate?.loginDidClose(self)
    }

    @IBAction
    func registerAction() {
        delegate?.loginDidTapRegister(self)
    }
    
    @IBAction
    func backgroundTap() {
        emailTextField.resignFirstResponder()
    }
    
    @IBAction
    func usernameDidEndOnExit() {
        guard continueButton.isEnabled else { return }
        continueButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction
    func usernameEditingDidBegin() {
        let transform = CGAffineTransform.identity
            .translatedBy(x: -placeholderLabel.bounds.width*0.1, y: -30)
            .scaledBy(x: 0.8, y: 0.8)
            
        animatePlaceholder(transform: transform)
    }

    @IBAction
    func usernameEditingDidEnd() {
        guard emailTextField.text?.isEmpty == true else { return }
        animatePlaceholder(transform: .identity)
    }
    
    @IBAction
    func usernameEditingDidChange() {
        setButton(enabled: valid(text: emailTextField.text ?? ""), animated: true)
    }

    func animatePlaceholder(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            self.placeholderLabel.transform = transform
        }
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
        setButton(enabled: false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cancellable = show.merge(with: hide).sink { height in
            self.bottomPadding.constant = height
            
            UIView.animate(withDuration: 0.3, animations: self.view.layoutIfNeeded)
        }
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
    
    func setButton(enabled: Bool, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.2 : 0) {
            self.continueButton.isEnabled = enabled
            self.continueButton.backgroundColor = enabled ? #colorLiteral(red: 0.9058823529, green: 0.08235294118, blue: 0.3803921569, alpha: 1) : #colorLiteral(red: 0.9138599057, green: 0.3538272705, blue: 0.5565057481, alpha: 1)
        }
    }

}
