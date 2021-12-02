import Foundation

public protocol InitialUseCaseInput {
  func execute() -> RootChild
}

public protocol InitialUseCaseOutput {
  func show(_ child: RootChild)
}

public protocol Policy {
  func fulfilled() -> Bool
}

public protocol FirstRunRepository {
  func isFirstRun() -> Bool
}

public struct FirstRunPolicy: Policy {
  public let repository: FirstRunRepository

  public init(repository: FirstRunRepository) {
    self.repository = repository
  }

  public func fulfilled() -> Bool {
    repository.isFirstRun()
  }
}



public struct InitialUseCase: InitialUseCaseInput {
  public let policies: [RootChild: Policy]
  public let `default`: RootChild

  public init(policies: [RootChild: Policy], default: RootChild) {
    self.policies = policies
    self.default = `default`
  }

  public func execute() -> RootChild {
    if let (child, _) = policies.first(where: { _, policy in policy.fulfilled() }) {
      return child
    } else {
      return `default`
    }
  }
}

extension InitialUseCase {
  public init() {
    let policies: [RootChild: Policy] = [
      .welcome: FirstRunPolicy(repository: HardcodedFirstRunRepository())
    ]

    self.init(policies: policies, default: .guest)
  }
}

struct HardcodedFirstRunRepository: FirstRunRepository {
  public func isFirstRun() -> Bool {
//    .random()
    true
  }
}
