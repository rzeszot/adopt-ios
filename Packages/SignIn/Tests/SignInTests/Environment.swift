import Foundation
import Mocky

extension Environment {
  public func load(from file: String, bundle: Bundle) {
    guard let url = bundle.url(forResource: file, withExtension: nil, subdirectory: "Responses") else { return }

    let content = try! String(contentsOf: url)
    let chunks = content.components(separatedBy: "\n---\n")

    for option in chunks[0].split(separator: "\n") {
      let parts = option.components(separatedBy: ": ")
      let key = parts[0]
      let value = parts[1]

      switch key {
      case "delay":
        delay = TimeInterval(value)
      default:
        fatalError()
      }
    }

    for header in chunks[1].split(separator: "\n") {
      let parts = header.components(separatedBy: ": ")
      let key = parts[0]
      let value = parts[1]

      switch key {
      case "status":
        response.status = Int(value)
      default:
        response.headers.set(value, for: key)
      }
    }

    response.body = chunks[2].data(using: .utf8)
  }
}
