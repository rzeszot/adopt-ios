import Process

enum Command: Process.Command {
  case back
  case done
  case cancel
  case ok
  case submit(username: String)
}
