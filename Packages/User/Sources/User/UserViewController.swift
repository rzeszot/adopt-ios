import UIKit

public final class UserViewController: UIViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()

    let text = String(describing: type(of: self))
      .replacingOccurrences(of: "ViewController", with: "")
      .lowercased()

    view.backgroundColor = .systemBackground
    label.text = text

    _ = submitButton
  }

  private lazy var label: UILabel = {
    let label = UILabel()

    label.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    return label
  }()

  public var submit: (() -> Void)!

  @objc func submitAction() {
    submit()
  }

  private lazy var submitButton: UIButton = {
    let button = UIButton()
    button.configuration = .borderedProminent()
    button.configuration?.title = "Logout"
    button.addTarget(self, action: #selector(submitAction), for: .touchUpInside)

    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      button.heightAnchor.constraint(equalToConstant: 50)
    ])

    return button
  }()

}

extension UserViewController {
  public static func build(submit: @escaping () -> Void) -> UserViewController {
    let vc = UserViewController()
    vc.submit = submit
    return vc
  }
}
