import UIKit

public final class ContainerController: UIViewController {

  public var factory: Factory!

  // MARK: -

  public override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
  }

  public func use(_ vc: UIViewController) {
    if let vc = vc as? UIAlertController {
      present(vc, animated: true)
    } else {
      Task {
        if let old = children.first {
          await hide(vc: old)
          await show(vc: vc)
        } else {
          await show(vc: vc, animated: false)
        }
      }
    }
  }

  // MARK: -

  private func hide(vc: UIViewController, animated: Bool = true) async {
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      vc.willMove(toParent: nil)

      UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
        vc.view.alpha = 0
      }, completion: { _ in
        vc.view.removeFromSuperview()
        vc.removeFromParent()

        continuation.resume()
      })
    }
  }

  private func show(vc: UIViewController, animated: Bool = true) async {
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      addChild(vc)

      view.addSubview(vc.view)
      vc.view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        vc.view.leftAnchor.constraint(equalTo: view.leftAnchor),
        vc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        vc.view.topAnchor.constraint(equalTo: view.topAnchor),
        vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])

      vc.view.alpha = 0

      UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
        vc.view.alpha = 1
      }, completion: { _ in
        vc.didMove(toParent: self)

        continuation.resume()
      })
    }
  }

}
