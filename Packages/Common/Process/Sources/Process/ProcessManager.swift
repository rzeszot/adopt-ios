import Foundation

public class ProcessManager {

  struct Handler {
    let command: Command.Type
    let state: State.Type
    let execute: (State, Command) async -> State
  }

  public private(set) var current: State!
  private(set) var handlers: [Handler] = []

  public init() {

  }

  public func start(handler: @escaping () -> State) {
    current = handler()
  }

  public func register<S: State, C: Command>(handler: @escaping (S, C) async -> State) throws {
    guard transition(state: S.self, command: C.self) == nil else {
      throw DuplicatedTransitionError()
    }

    let entry = Handler(command: C.self, state: S.self) { source, command -> State in
      await handler(source as! S, command as! C)
    }
    handlers.append(entry)
  }

  public func handle(_ command: Command) async throws {
    let handler = try find(for: command)
    current = await handler.execute(current, command)
  }

  func transition(state: State.Type, command: Command.Type) -> Handler? {
    handlers.first { handler in
      handler.state == state && handler.command == command
    }
  }

  func find(for command: Command) throws -> Handler {
    let found = handlers.filter { handler in
      handler.command == type(of: command) && handler.state == type(of: current!)
    }

    guard let found = found.first else { throw InvalidTransitionError() }
    return found
  }

}
