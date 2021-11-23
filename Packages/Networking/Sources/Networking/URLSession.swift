// swiftlint:disable force_cast

import Foundation
import Unexpected

extension URLSession {
  public func perform<T: Response>(request: URLRequest, using parser: Parser) async throws -> T {
    let (data, response) = try await data(for: request)
    let object = try parser.parse(response: response as! HTTPURLResponse, data: data)

    if let object = object as? T {
      return object
    } else {
      throw (object as? Error) ?? UnexpectedError()
    }
  }
}
