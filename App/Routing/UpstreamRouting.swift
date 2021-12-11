import Foundation

public protocol UpstreamRouting: Routing {
  var upstream: Routing? { get }
}

extension UpstreamRouting {
  public func upstream<T>(of routable: T.Type) -> T? {
    var ptr: Routing? = self

    while ptr != nil {
      if let ptr = ptr as? T {
        return ptr
      }

      ptr = (ptr as? UpstreamRouting)?.upstream
    }

    return nil
  }
}
