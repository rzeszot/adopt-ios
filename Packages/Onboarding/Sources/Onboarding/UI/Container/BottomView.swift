import UIKit

class BottomView: UIView {

  lazy var skipButton: UIButton = {
    let root = UIButton()
    root.configuration = .skip()

    addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leadingAnchor.constraint(equalTo: leadingAnchor),
      root.centerYAnchor.constraint(equalTo: centerYAnchor),
      root.heightAnchor.constraint(equalToConstant: 42)
    ])

    return root
  }()

  lazy var nextButton: UIButton = {
    let root = UIButton()
    root.configuration = .next()

    addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.trailingAnchor.constraint(equalTo: trailingAnchor),
      root.centerYAnchor.constraint(equalTo: centerYAnchor),
      root.heightAnchor.constraint(equalToConstant: 42)
    ])

    return root
  }()


  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    _ = skipButton
    _ = nextButton
  }

}

extension UIButton.Configuration {
  static func skip() -> Self {
    var config = Self.borderless()
    config.baseForegroundColor = .systemGray
    config.title = "Skip"

    return config
  }

  static func next() -> Self {
    var config = Self.borderedTinted()
    config.title = "Next"
    return config
  }
}
