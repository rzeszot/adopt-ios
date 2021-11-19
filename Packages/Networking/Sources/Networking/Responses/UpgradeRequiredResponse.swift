import Foundation

public struct UpgradeRequiredResponse: Response, Error {
  public static let code = 426
  public let url: URL?
}
