import UIKit

public final class ContainerController: UIViewController {

  public typealias Output = (ExitState) -> Void
  public var output: Output!

  var state: State!

  public func start(_ new: VisualState) {
    precondition(state == nil)

    state = new
    use(new.build(change: changer))
  }

  public func change(_ new: State) {
    precondition(state != nil)

    let old = state!
    state = new

    print("change [\(old)] -> [\(new)]")

    if let old = old as? SpecificationState {
      if !old.transitionable(to: new) {
        print("transition not allowed! [\(old)] -> [\(new)]")
      }

      if old.ignore(when: new) {
        return
      }
    }

    if let state = state as? ExitState {
      output(state)
    } else if let state = state as? VisualState {
      let vc = state.build(change: changer)

      if let alert = vc as? UIAlertController {
        present(alert, animated: true)
      } else {
        use(vc)
      }
    } else {
      print("wtf \(old) -> \(new)")
    }
  }

  private func changer(_ state: State) {
    DispatchQueue.main.async {
      self.change(state)
    }
  }

  // MARK: -

  private func use(_ new: UIViewController) {
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
