import UIKit

public final class WelcomeViewController: UIViewController {

  public var action: ((WelcomeAction) -> Void)!

  // MARK: -

  @objc func continueAction() {
    action(.done)
  }

  @objc func privacyAction() {
    action(.privacy)
  }

  // MARK: -

  public override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = UIImage(named: "Welcome/background")
  }
  // 2 3

  public override func loadView() {
    super.loadView()
    view.backgroundColor = .systemBackground

    _ = imageView
    _ = continueButton
    _ = privacyButton
  }

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill

    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
      imageView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])

    return imageView
  }()

  private lazy var continueButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
    button.configuration = .borderedProminent()
    button.configuration?.title = "Continue"
    button.configuration?.contentInsets = .init(top: 15, leading: 10, bottom: 15, trailing: 10)

    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.bottomAnchor.constraint(equalTo: privacyButton.topAnchor, constant: -20),
      button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
      button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
    ])

    return button
  }()

  private lazy var privacyButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(privacyAction), for: .touchUpInside)
    button.configuration = .plain()
    button.configuration?.buttonSize = .mini
    button.configuration?.title = "Privacy Policy"

    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])

    return button
  }()

}

extension WelcomeViewController {
  public static func build() -> WelcomeViewController {
    let vc = WelcomeViewController()
    vc.action = { action in
      print("welcome \(action)")
    }
    return vc
  }
}
