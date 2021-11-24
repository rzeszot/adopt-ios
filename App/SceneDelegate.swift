import UIKit
import RequestPasswordReset
import ConfirmPasswordChange

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: scene)
    window.rootViewController = TestViewController()
    window.makeKeyAndVisible()

    self.window = window
  }

}

class TestViewController: UIViewController {

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground

    let request = UIButton(primaryAction: UIAction(handler: { _ in
      let vc = RequestPasswordReset.Builder.request(Input(username: "contact@rzeszot.pro", close: { reason in
        print("close request password reset with reason:\(reason)")
        self.dismiss(animated: true)
      }))
      self.present(vc, animated: true)
    }))
    request.configuration = .bordered()
    request.configuration?.title = "Request Password Reset"
    view.addSubview(request)
    request.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      request.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      request.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    let confirm = UIButton(primaryAction: UIAction(handler: { _ in
      let vc = ConfirmPasswordChange.Builder.confirm(Input(username: "contact@rzeszot.pro", code: "authcode", close: { reason in
        print("close confirm password reset with reason:\(reason)")
        self.dismiss(animated: true)
      }))
      self.present(vc, animated: true)
    }))
    confirm.configuration = .bordered()
    confirm.configuration?.title = "Confirm Password Reset"
    view.addSubview(confirm)
    confirm.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      confirm.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      confirm.topAnchor.constraint(equalTo: request.bottomAnchor, constant: 10)
    ])
  }

}
