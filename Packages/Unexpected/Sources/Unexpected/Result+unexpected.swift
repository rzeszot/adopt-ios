import Foundation

extension Result {
  public static var unexpected: Result<Success, Error> {
    .failure(UnexpectedError())
  }
}
