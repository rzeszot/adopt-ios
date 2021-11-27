import Process

struct CloseState: ExitState {
  let reason: Input.CloseReason
}

extension CloseState: SpecificationState {
  func transitionable(to state: State) -> Bool {
    false
  }
}
