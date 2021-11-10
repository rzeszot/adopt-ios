import UIKit

public struct Welcome {
  public struct Input {
    let privacy: () -> Void
    let done: () -> Void

    public init(privacy: @escaping () -> Void, done: @escaping () -> Void) {
      self.privacy = privacy
      self.done = done
    }
  }

  public static func build(_ input: Input) -> UIViewController {
    let vc = ViewController()
    vc.input = input
    return vc
  }
}

class ViewController: UIViewController {

  // MARK: -

  var input: Welcome.Input!

  // MARK: - Outlets

  private var continueButton: UIButton!
  private var privacyButton: UIButton!

  // MARK: -

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground

    privacyButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in self.input.privacy() }))
    privacyButton.configuration = .plain()
    privacyButton.configuration?.buttonSize = .mini
    privacyButton.configuration?.title = "Privacy Policy"

    continueButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in self.input.done() }))
    continueButton.configuration = .tinted()
    continueButton.configuration?.title = "Continue"
    continueButton.configuration?.contentInsets = .init(top: 15, leading: 10, bottom: 15, trailing: 10)

    view.addSubview(privacyButton)
    privacyButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])

    view.addSubview(continueButton)
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      continueButton.bottomAnchor.constraint(equalTo: privacyButton.topAnchor, constant: -20),
      continueButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
      continueButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
    ])
  }

}
