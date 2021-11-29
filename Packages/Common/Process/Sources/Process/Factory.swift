import UIKit

public class Factory: Gate {

  let transition: (UIViewController) -> Void
  let exit: (ExitState) -> Void

  public init(transition: @escaping (UIViewController) -> Void, exit: @escaping (ExitState) -> Void) {
    self.transition = { vc in
      DispatchQueue.main.async {
        transition(vc)
      }
    }
    self.exit = exit
  }

  private var creators: [(create: (State) -> UIViewController, state: State.Type)] = []
  private var state: State?

  public func register<C: Creator>(_ creator: C, for state: State.Type) {
    creators.append((create: { state in
      creator.build(state: state as! C.S)
    }, state: state))
  }

  func builder(for state: State) -> ((State) -> UIViewController)? {
    creators.first { $0.state == type(of: state) }?.create
  }

  public func transition(to new: State) {
    guard Thread.isMainThread else {
      DispatchQueue.main.async { self.transition(to: new) }
      return
    }

    if let state = new as? ExitState {
      exit(state)
    } else if let state = state {
      let old = state
      self.state = new

      print("transition \(old) -> \(new)")

      if let old = old as? AnimatableState, !old.animatable(when: new) {
        return
      }

      let vc = builder(for: new)!(new)
      transition(vc)
    } else {
      state = new

      print("transition nil -> \(new)")
      transition(builder(for: new)!(new))
    }
  }

}
