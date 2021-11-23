import UIKit

public struct Builder {
  public static func confirm(_ input: ConfirmInput) -> UIViewController {
    let container = ContainerController()

    let change = ChangePasswordViewController()
    change.output = (close: {
      input.close(.cancel)
    }, submit: { password in
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
