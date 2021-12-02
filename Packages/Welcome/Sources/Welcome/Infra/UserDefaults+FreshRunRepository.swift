import Foundation

private let key = "was-run-before"

extension UserDefaults: FreshRunRepository {
  var value: Bool? {
    set(value) {
      set(value, forKey: key)
    }
    get {
      value(forKey: key) as? Bool
    }
  }

  // MARK: - FreshRunRepository

  public func reset() {
    value = nil
  }

  public func satisfied() -> Bool {
    value == true
  }

  public func set(fresh: Bool) {
    value = fresh
  }
}
