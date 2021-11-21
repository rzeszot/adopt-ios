import Foundation

public struct UpgradeRequiredResponse: Response, Error {
  public static let code = 426
  public let version: String?
  public let url: URL?
}
