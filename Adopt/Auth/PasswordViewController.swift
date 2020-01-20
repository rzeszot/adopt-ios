//
//  Adopt
//
//  Created by Kinga on 15/01/2020.
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
    var emailLabel: UILabel!
    
    @IBOutlet
    var passwordTextField: UITextField!
    
    @IBOutlet
    var placeholderLabel: UILabel!
    
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
    
    @IBAction
    func passwordDidEndOnExit() {
        guard continueButton.isEnabled else { return }
        continueButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction
    func passwordEditingDidBegin() {
        let transform = CGAffineTransform.identity
            .translatedBy(x: -placeholderLabel.bounds.width*0.1, y: -30)
            .scaledBy(x: 0.8, y: 0.8)
            
        animatePlaceholder(transform: transform)
    }

    @IBAction
    func passwordEditingDidEnd() {
        guard passwordTextField.text?.isEmpty == true else { return }
        animatePlaceholder(transform: .identity)
    }
    
    @IBAction
    func passwordEditingDidChange() {
        setButton(enabled: valid(text: passwordTextField.text ?? ""), animated: true)
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
        
        toggleAction()
        
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
