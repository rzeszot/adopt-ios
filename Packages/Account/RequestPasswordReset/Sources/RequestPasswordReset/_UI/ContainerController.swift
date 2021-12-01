import UIKit
import Process

class ContainerController: UIViewController, Gate {

  var handler: Handler!
  var close: ((Input.CloseReason) -> Void)!

  // MARK: -

  override func viewDidLoad() {
    super.viewDidLoad()
    Task {
      await use(build(for: handler.state)!, animated: false)
    }
  }

  func dispatch(_ command: Command) {
    Task {
      try! await handler.handle(command)

      if let state = handler.state as? CloseState {
        close(state.reason)
      } else if let vc = build(for: handler.state) {
        await use(vc)
      }
    }
  }

  // MARK: -

  private func build(for state: State) -> UIViewController? {
    switch state {
    case let state as EnterUsernameState:
      return EnterUsernameCreator(gate: self).build(state: state)
    case let state as UsernameNotFoundState:
      return UsernameNotFoundCreator(gate: self).build(state: state)
    case let state as EmailSentState:
      return EmailSentCreator(gate: self).build(state: state)
    default:
      return nil
    }
  }

  // MARK: -

  @MainActor
  private func use(_ vc: UIViewController, animated: Bool = true) async {
    if let vc = vc as? UIAlertController {
      await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
        present(vc, animated: animated) {
          continuation.resume()
        }
      }
    } else {
      if let old = children.first {
        await hide(vc: old, animated: animated)
        await show(vc: vc, animated: animated)
      } else {
        await show(vc: vc, animated: animated)
      }
    }
  }

  @MainActor
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

  @MainActor
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
