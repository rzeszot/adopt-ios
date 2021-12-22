import UIKit

public class ChangePasswordViewController: UIViewController {

  public var output: ChangePasswordOutput!

  // MARK: -

  @objc func closeAction() {
    output.close()
  }

  @objc func submitAction() {
    let password = firstPasswordTextField.text ?? ""
    output.submit(password)
  }

  @objc func backgroundAction() {
    firstPasswordTextField.resignFirstResponder()
    secondPasswordTextField.resignFirstResponder()
  }

  @objc func textFieldEditingDidEnd(_ textField: UITextField) {
    if textField == firstPasswordTextField {
      firstPasswordTextField.resignFirstResponder()
      secondPasswordTextField.becomeFirstResponder()
    } else if textField == secondPasswordTextField {
      secondPasswordTextField.resignFirstResponder()
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

  private lazy var hintView: HintView = {
    let root = HintView()
    root.imageView.image = UIImage(systemName: "lock.circle")
    root.titleLabel.text = t("confirm-password-change.change-password.hint-title")
    root.subtitleLabel.text = t("confirm-password-change.change-password.hint-subtitle")
    root.setContentCompressionResistancePriority(.required, for: .vertical)

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.layoutMargins.left),
      root.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.layoutMargins.right),
      root.topAnchor.constraint(equalTo: closeButton.bottomAnchor).priority(700),
      root.topAnchor.constraint(greaterThanOrEqualTo: closeButton.topAnchor)
    ])

    return root
  }()

  private lazy var wrapperView: UIView = {
    let root = UIView()
    root.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.leftAnchor),
      root.rightAnchor.constraint(equalTo: view.rightAnchor),
      root.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
//      root.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor),
      root.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).priority(999)
    ])

    return root
  }()

  private lazy var credentialsView: UIView = {
    let root = UIView()

    wrapperView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: wrapperView.layoutMargins.left),
      root.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -wrapperView.layoutMargins.right),
      root.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).priority(600),
      root.topAnchor.constraint(greaterThanOrEqualTo: hintView.bottomAnchor, constant: 20),
      root.bottomAnchor.constraint(lessThanOrEqualTo: submitButton.topAnchor, constant: -20)
    ])

    return root
  }()

  private lazy var firstPasswordTextField: UITextField = {
    let root = TextField()
    root.placeholder = t("confirm-password-change.change-password.new-password-field")
    root.textContentType = .password
    root.returnKeyType = .next
    root.isSecureTextEntry = true
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

  private lazy var secondPasswordTextField: UITextField = {
    let root = TextField()
    root.placeholder = t("confirm-password-change.change-password.confirmation-password-field")
    root.textContentType = .password
    root.returnKeyType = .go
    root.isSecureTextEntry = true
    root.backgroundColor = .secondarySystemBackground
    root.layer.cornerRadius = 5
    root.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEndOnExit)

    credentialsView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.heightAnchor.constraint(equalToConstant: 50),
      root.leftAnchor.constraint(equalTo: credentialsView.leftAnchor),
      root.rightAnchor.constraint(equalTo: credentialsView.rightAnchor),
      root.topAnchor.constraint(equalTo: firstPasswordTextField.bottomAnchor, constant: 10),
      root.bottomAnchor.constraint(equalTo: credentialsView.bottomAnchor)
    ])

    return root
  }()

  private lazy var submitButton: UIButton = {
    let root = UIButton()
    root.configuration = .borderedProminent()
    root.configuration?.title = t("confirm-password-change.change-password.submit-action")
    root.addTarget(self, action: #selector(submitAction), for: .touchUpInside)

    wrapperView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.heightAnchor.constraint(equalToConstant: 50),
      root.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: wrapperView.layoutMargins.left),
      root.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -wrapperView.layoutMargins.right),
      root.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -wrapperView.layoutMargins.bottom)
    ])

    return root
  }()

  public override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundAction)))
    view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    _ = hintView
    _ = closeButton
    _ = wrapperView
        _ = credentialsView
            _ = firstPasswordTextField
            _ = secondPasswordTextField
        _ = submitButton
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    firstPasswordTextField.text = "the password"
    secondPasswordTextField.text = "the password"
  }

  private func input(enabled: Bool) {
    firstPasswordTextField.isEnabled = enabled
    secondPasswordTextField.isEnabled = enabled
    submitButton.isEnabled = enabled
  }
}
