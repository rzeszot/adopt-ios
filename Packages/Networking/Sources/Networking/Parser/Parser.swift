import Foundation
import Unexpected

public struct Parser {
  public let types: [Response.Type]
  public let decoder: JSONDecoder

  public init(types: [Response.Type], decoder: JSONDecoder = .default) {
    precondition(Set(types.map { $0.code }).count == types.count)

    self.types = types
    self.decoder = decoder
  }

  // MARK: -

  public func parse(response: HTTPURLResponse, data: Data) throws -> Response {
    guard let type = type(for: response) else {
      throw UnexpectedError()
    }
    return try decode(data: data, type: type)
  }

  // MARK: -

  func type(for request: HTTPURLResponse) -> Response.Type? {
    types.first { $0.code == request.statusCode }
  }

  // MARK: -

  func decode(data: Data, type: Response.Type) throws -> Response {
    struct Wrapper: Decodable {
      let response: Response

      init(from decoder: Decoder) throws {
        let type = decoder.userInfo[.type]! as! Response.Type
        response = try type.init(from: decoder)
      }
    }

   decoder.userInfo[.type] = type

    return try decoder.decode(Wrapper.self, from: data).response
  }
}

extension Parser: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Response.Type...) {
    self.init(types: elements)
  }
}

private extension CodingUserInfoKey {
  static let type = CodingUserInfoKey(rawValue: "type")!
}

extension JSONDecoder {
  public static var `default`: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.assumesTopLevelDictionary = true
    return decoder
  }
}
