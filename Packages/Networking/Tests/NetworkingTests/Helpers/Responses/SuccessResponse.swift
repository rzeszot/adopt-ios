import Networking

struct SuccessResponse: Response {
  static var code = 200

  let number: Int
}
