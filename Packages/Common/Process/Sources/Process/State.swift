import Foundation

public protocol State {

}

extension DefaultStringInterpolation {
  public mutating func appendInterpolation(_ state: State) {
    appendLiteral("\(type(of: state))")
  }
}
