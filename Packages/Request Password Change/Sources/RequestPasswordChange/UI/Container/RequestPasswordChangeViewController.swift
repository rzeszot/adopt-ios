import UIKit

public class RequestPasswordChangeViewController: UIViewController {

  public var output: RequestPasswordChangeOutput!

  public override func loadView() {
    super.loadView()
    view.backgroundColor = .systemBackground
  }

  public func show(vc new: UIViewController) {
    if let old = children.first {
      Task {
        old.willMove(toParent: nil)
        addChild(new)

        await fade(out: old.view)

        old.view.removeFromSuperview()
        old.removeFromParent()

        inject(child: new.view)
        await fade(in: new.view)

        new.didMove(toParent: self)
      }
    } else {
      addChild(new)
      inject(child: new.view)
      new.didMove(toParent: self)
    }
  }

  // MARK: -

  private func inject(child: UIView) {
    child.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(child)
    NSLayoutConstraint.activate([
      child.leftAnchor.constraint(equalTo: view.leftAnchor),
      child.rightAnchor.constraint(equalTo: view.rightAnchor),
      child.topAnchor.constraint(equalTo: view.topAnchor),
      child.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func fade(in view: UIView) async {
    view.alpha = 0
    await animate(duration: 0.2) { view.alpha = 1 }
  }

  private func fade(out view: UIView) async {
    await animate(duration: 0.2) { view.alpha = 0 }
  }

  private func animate(duration: TimeInterval, animations: @escaping () -> Void) async {
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      UIView.animate(withDuration: duration, animations: animations) { _ in
        continuation.resume()
      }
    }
  }

}
