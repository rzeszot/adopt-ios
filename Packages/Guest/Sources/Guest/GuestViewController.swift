import UIKit

public final class GuestViewController: UIViewController {

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

  public func show(vc new: UIViewController) {
    if let old = children.first {
      old.willMove(toParent: nil)
      old.view.removeFromSuperview()
      old.removeFromParent()
    }

    addChild(new)
    new.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(new.view)
    NSLayoutConstraint.activate([
      new.view.leftAnchor.constraint(equalTo: view.leftAnchor),
      new.view.rightAnchor.constraint(equalTo: view.rightAnchor),
      new.view.topAnchor.constraint(equalTo: view.topAnchor),
      new.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    new.didMove(toParent: self)
  }

}
