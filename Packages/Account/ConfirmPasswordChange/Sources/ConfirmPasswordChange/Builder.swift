import UIKit

public struct Builder {
  public static func confirm(_ input: Input) -> UIViewController {
    let container = ContainerController()

    let change = ChangePasswordViewController()
    change.output = (close: {
      input.close(.cancel)
    }, submit: { _ in
      let updated = PasswordUpdatedViewController()
      updated.output = (close: {
        input.close(.dismiss)
      }, done: {
        input.close(.authorize)
      })

      container.use(updated)
    })

    container.use(change)

    return container
  }
}
