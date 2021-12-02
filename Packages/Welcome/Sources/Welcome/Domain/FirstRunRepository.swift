import Foundation

public protocol FreshRunRepository {
  func reset()
  func satisfied() -> Bool
  func set(fresh: Bool)
}

extension FreshRunRepository {
  func mark() {
    set(fresh: false)
  }
}
