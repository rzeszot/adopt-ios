import UIKit

final class ContainerController: UIViewController {

  func use(_ new: UIViewController) {
    if let old = children.first {
      old.willMove(toParent: nil)
      old.view.removeFromSuperview()
      old.removeFromParent()
    }

    addChild(new)
    view.addSubview(new.view)
    new.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      new.view.leftAnchor.constraint(equalTo: view.leftAnchor),
      new.view.rightAnchor.constraint(equalTo: view.rightAnchor),
      new.view.topAnchor.constraint(equalTo: view.topAnchor),
      new.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    new.didMove(toParent: self)
  }

}
