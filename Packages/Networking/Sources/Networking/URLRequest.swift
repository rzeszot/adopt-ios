import Foundation

extension URLRequest {
  public mutating func body<T: Encodable>(json: T, using encoder: JSONEncoder = .default) throws {
    httpBody = try encoder.encode(json)
    addValue("application/json", forHTTPHeaderField: "Content-Type")
  }

  public static func post(_ url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    return request
  }
}

extension JSONEncoder {
  public static var `default`: JSONEncoder {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
    return encoder
  }
}
