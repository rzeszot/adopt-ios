import Process

struct CloseState: State {
  typealias CloseReason = Input.CloseReason
  let context: RequestPasswordResetContext
  let reason: CloseReason
}
