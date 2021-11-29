import Foundation

public protocol State {

}

extension DefaultStringInterpolation {
  mutating func appendInterpolation(_ state: State) {
    appendLiteral("\(type(of: state))")
  }
}
