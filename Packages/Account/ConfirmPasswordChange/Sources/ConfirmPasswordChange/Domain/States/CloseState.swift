import Process

struct CloseState: State {
  let reason: Input.CloseReason
}
