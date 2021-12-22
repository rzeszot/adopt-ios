import UIKit

public final class SettingsViewController: UIViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()

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
