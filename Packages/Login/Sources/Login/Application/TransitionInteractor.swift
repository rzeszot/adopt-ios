import Foundation

struct TransitionInteractor: TransitionUseCaseInput {
  let output: LoginOutput

  func close() {
    output.close()
  }

  func remind() {
    print("output.remind")
  }
}
