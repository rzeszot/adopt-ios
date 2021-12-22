import UIKit

public class EnterUsernameViewController: UIViewController {

  public var viewModel: EnterUsernameViewModel!
  public var output: EnterUsernameOutput!

  // MARK: -

  @objc func closeAction() {
    output.close()
  }

  @objc func submitAction() {
    let username = usernameTextField.text ?? ""
    output.submit(username)
  }

  @objc func backgroundAction() {
    usernameTextField.resignFirstResponder()
  }

  @objc func textFieldEditingDidEnd(_ textField: UITextField) {
    if textField == usernameTextField {
      usernameTextField.resignFirstResponder()
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
    root.titleLabel.text = t("remind-password.enter-username.hint-title")
    root.subtitleLabel.text = t("remind-password.enter-username.hint-subtitle")
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

  private lazy var usernameTextField: UITextField = {
    let root = TextField()
    root.placeholder = t("remind-password.enter-username.username-field")
    root.textContentType = .emailAddress
    root.returnKeyType = .go
    root.backgroundColor = .secondarySystemBackground
    root.layer.cornerRadius = 5
    root.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEndOnExit)

    credentialsView.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.heightAnchor.constraint(equalToConstant: 50),
      root.leftAnchor.constraint(equalTo: credentialsView.leftAnchor),
      root.rightAnchor.constraint(equalTo: credentialsView.rightAnchor),
      root.topAnchor.constraint(equalTo: credentialsView.topAnchor),
      root.bottomAnchor.constraint(equalTo: credentialsView.bottomAnchor)
    ])

    return root
  }()

  private lazy var submitButton: UIButton = {
    let root = UIButton()
    root.configuration = .borderedProminent()
    root.configuration?.title = t("remind-password.enter-username.submit-action")
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
    view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    _ = hintView
    _ = closeButton
    _ = wrapperView
        _ = credentialsView
            _ = usernameTextField
        _ = submitButton
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    usernameTextField.text = viewModel.username
  }

}
