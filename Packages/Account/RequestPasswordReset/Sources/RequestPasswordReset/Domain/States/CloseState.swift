import Process

struct CloseState: ExitState {
  let reason: Input.CloseReason
}
