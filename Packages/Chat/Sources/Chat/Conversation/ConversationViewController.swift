import UIKit

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
      input.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).set(priority: .defaultLow),
      view.keyboardLayoutGuide.topAnchor.constraint(equalTo: input.view.bottomAnchor)
    ])

    input.didMove(toParent: self)

  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemYellow

    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundAction)))
  }

  @objc private func backgroundAction() {
    children.first?.resignFirstResponder()
  }

}
