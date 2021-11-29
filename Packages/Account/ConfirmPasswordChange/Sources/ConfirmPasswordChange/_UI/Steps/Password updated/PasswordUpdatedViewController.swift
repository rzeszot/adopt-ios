import UIKit

final class PasswordUpdatedViewController: UIViewController {

  var viewModel: PasswordUpdatedViewModel!
  var output: PasswordUpdatedOutput!

  // MARK: -

  @objc func closeAction() {
    output.close()
  }

  @objc func continueAction() {
    output.done()
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
    root.titleLabel.text = t("confirm-password-change.password-updated.hint-title")
    root.subtitleLabel.text = t("confirm-password-change.password-updated.hint-subtitle")
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
      root.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])

    return root
  }()

  private lazy var continueButton: UIButton = {
    let root = UIButton()
    root.configuration = .borderedProminent()
    root.configuration?.title = t("confirm-password-change.password-updated.continue-action")
    root.addTarget(self, action: #selector(continueAction), for: .touchUpInside)

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

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    _ = hintView
    _ = closeButton
    _ = wrapperView
        _ = continueButton
  }

}
