import UIKit

func t(_ key: String) -> String {
  return  NSLocalizedString(key, comment: key)
}

class ViewController: UIViewController {

  // MARK: -

  @objc func closeAction() {
    print("action | close")
  }

  @objc func remindAction() {
    print("action | remind")
  }

  @objc func loginAction() {
    print("action | login")
  }

  @objc func backgroundAction() {
    usernameTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
  }

  @objc func textFieldEditingDidEnd(_ textField: UITextField) {
    if textField == usernameTextField {
      usernameTextField.resignFirstResponder()
      passwordTextField.becomeFirstResponder()
    } else if textField == passwordTextField {
      passwordTextField.resignFirstResponder()
    }
  }

  // MARK: -

  private lazy var closeButton: UIButton = {
    let root = UIButton()
    root.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    root.configuration = .tinted()
    root.configuration?.image = .init(systemName: "xmark")

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.widthAnchor.constraint(equalTo: root.heightAnchor, multiplier: 1),
      root.widthAnchor.constraint(equalToConstant: 42),
      root.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      root.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
    ])

    return root
  }()

  private lazy var wrapperView: UIView = {
    let root = UIView()

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.layoutMargins.left),
      root.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.layoutMargins.right),
      root.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
      root.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
    ])

    return root
  }()

  private lazy var credentialsView: UIView = {
    let root = UIView()

    wrapperView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.layoutMargins.left),
      root.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.layoutMargins.right),
      root.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor)
    ])

    return root
  }()

  private lazy var usernameTextField: UITextField = {
    let root = TextField()
    root.placeholder = t("sign-in.email")
    root.textContentType = .emailAddress
    root.keyboardType = .emailAddress
    root.returnKeyType = .next
    root.backgroundColor = .secondarySystemBackground
    root.layer.cornerRadius = 5
    root.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEndOnExit)

    credentialsView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.heightAnchor.constraint(equalToConstant: 50),
      root.leftAnchor.constraint(equalTo: credentialsView.leftAnchor),
      root.rightAnchor.constraint(equalTo: credentialsView.rightAnchor),
      root.topAnchor.constraint(equalTo: credentialsView.topAnchor)
    ])

    return root
  }()

  private lazy var passwordTextField: UITextField = {
    let root = TextField()
    root.textContentType = .password
    root.returnKeyType = .go
    root.isSecureTextEntry = true
    root.placeholder = t("sign-in.password")
    root.backgroundColor = .secondarySystemBackground
    root.layer.cornerRadius = 5
    root.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEndOnExit)

    credentialsView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.heightAnchor.constraint(equalToConstant: 50),
      root.leftAnchor.constraint(equalTo: credentialsView.leftAnchor),
      root.rightAnchor.constraint(equalTo: credentialsView.rightAnchor),
      root.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10)
    ])

    return root
  }()

  private lazy var remindButton: UIButton = {
    let root = UIButton()
    root.configuration = .borderless()
    root.configuration?.title = t("sign-in.remind-action")
    root.configuration?.buttonSize = .small
    root.addTarget(self, action: #selector(remindAction), for: .touchUpInside)

    credentialsView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.trailingAnchor.constraint(equalTo: credentialsView.trailingAnchor),
      root.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10)
    ])

    return root
  }()

  private lazy var loginButton: UIButton = {
    let root = UIButton()
    root.configuration = .borderedProminent()
    root.configuration?.title = t("sign-in.login-action")
    root.addTarget(self, action: #selector(loginAction), for: .touchUpInside)

    credentialsView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.heightAnchor.constraint(equalToConstant: 50),
      root.leftAnchor.constraint(equalTo: credentialsView.leftAnchor),
      root.rightAnchor.constraint(equalTo: credentialsView.rightAnchor),
      root.topAnchor.constraint(equalTo: remindButton.bottomAnchor, constant: 10),
      root.bottomAnchor.constraint(equalTo: credentialsView.bottomAnchor)
    ])

    return root
  }()

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundAction)))
    view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    _ = closeButton
    _ = wrapperView
        _ = credentialsView
            _ = usernameTextField
            _ = passwordTextField
            _ = remindButton
            _ = loginButton
  }

}

class TextField: UITextField {
  let padding: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }

  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: padding)
  }
}
