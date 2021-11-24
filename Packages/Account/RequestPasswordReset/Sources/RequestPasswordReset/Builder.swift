import UIKit

public struct Builder {
  public static func request(_ input: Input) -> UIViewController {
    let container = ContainerController()

    let enter = EnterUsernameViewController()
    enter.viewModel = EnterUsernameViewModel(username: input.username)
    enter.output = (close: {
      input.close(.cancel)
    }, submit: { username in
      let sent = EmailSentViewController()
      sent.viewModel = EmailSentViewModel(username: username)
      sent.back = {
        container.use(enter)
      }
      sent.submit = {
        input.close(.done)
      }
      container.use(sent)
    })

    container.use(enter)

    return container
  }
}
