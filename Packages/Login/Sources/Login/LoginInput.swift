import Foundation

public struct LoginInput {
  public enum Gateway {
    case production(URL)
    case stub
    case custom(LoginNetworkGateway)
  }

  let gateway: Gateway

  public init(gateway: Gateway) {
    self.gateway = gateway
  }
}
