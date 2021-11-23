import UIKit

class EmailSentViewController: UIViewController {

  var viewModel: EmailSentViewModel!

  // MARK: -

  @objc func closeAction() {
    print("action | close")
  }

  @objc func submitAction() {
    print("action | submit")
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
    root.imageView.image = UIImage(systemName: "paperplane.circle")
    root.titleLabel.text = t("remind-password.email-sent.hint-title")
    root.subtitleLabel.text = t("remind-password.email-sent.hint-subtitle")

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.layoutMargins.left),
      root.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.layoutMargins.right),
      root.topAnchor.constraint(greaterThanOrEqualTo: closeButton.topAnchor).priority(900),
      root.topAnchor.constraint(equalTo: closeButton.bottomAnchor).priority(700)
    ])

    return root
  }()

  private lazy var submitButton: UIButton = {
    let root = UIButton()
    root.configuration = .borderedProminent()
    root.configuration?.title = t("remind-password.email-sent.submit-action")
    root.addTarget(self, action: #selector(submitAction), for: .touchUpInside)

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.heightAnchor.constraint(equalToConstant: 50),
      root.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.layoutMargins.left),
      root.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.layoutMargins.right),
      root.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.layoutMargins.bottom)
    ])

    return root
  }()

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    _ = hintView
    _ = closeButton
    _ = submitButton
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let text = t("remind-password.email-sent.hint-subtitle")
      .replacingOccurrences(of: "<email>", with: viewModel.username)

    hintView.subtitleLabel.text = text
  }

}
