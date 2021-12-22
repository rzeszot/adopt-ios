import UIKit

public final class PrivacyViewController: UIViewController {

  public var dismiss: (() -> Void)!

  @objc func dismissAction() {
    dismiss()
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Privacy Policy"
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissAction))

    let text = String(describing: type(of: self))
      .replacingOccurrences(of: "ViewController", with: "")
      .lowercased()

    view.backgroundColor = .systemBackground
    label.text = text
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

}
