import UIKit
import AwesomeKeyboardLayoutGuide

class ConversationViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let input = InputViewController()

    addChild(input)
    input.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(input.view)

    NSLayoutConstraint.activate([
      input.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
      input.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      input.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).set(priority: UILayoutPriority(100)),
      input.view.bottomAnchor.constraint(equalTo: view.awesomeKeyboardLayoutGuide.topAnchor),
      input.view.heightAnchor.constraint(lessThanOrEqualToConstant: 150)
    ])

    input.didMove(toParent: self)
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground

    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundAction)))
  }

  @objc private func backgroundAction() {
    children.first?.resignFirstResponder()
  }

}
