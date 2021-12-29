import UIKit

class StepViewController: UIViewController {

  var viewModel: StepViewModel? {
    didSet {
      titleLabel.text = viewModel?.title
      subtitleLabel.text = viewModel?.subtitle
      imageView.backgroundColor = .systemBlue
    }
  }

  // MARK: -

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.layoutMargins = UIEdgeInsets(top: 20, left: 50, bottom: 20, right: 50)
    view.insetsLayoutMarginsFromSafeArea = true

    _ = contentView
    _ = imageView
    _ = titleLabel
    _ = subtitleLabel
  }

  // MARK: -

  private lazy var contentView: UIView = {
    let root = UIView()

    root.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(root)
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
      root.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
      root.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      root.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
    ])
    return root
  }()

  private lazy var imageView: UIImageView = {
    let root = UIImageView()

    root.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(root)
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      root.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      root.topAnchor.constraint(equalTo: contentView.topAnchor),
      root.heightAnchor.constraint(equalTo: root.widthAnchor, multiplier: 9.0 / 16.0)
    ])
    return root
  }()

  private lazy var titleLabel: UILabel = {
    let root = UILabel()
    root.font = .preferredFont(forTextStyle: .headline)
    root.textColor = .label
    root.textAlignment = .center

    root.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(root)
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      root.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      root.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
    ])
    return root
  }()

  private lazy var subtitleLabel: UILabel = {
    let root = UILabel()
    root.font = .preferredFont(forTextStyle: .callout)
    root.textColor = .secondaryLabel
    root.textAlignment = .center
    root.numberOfLines = 0

    root.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(root)
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      root.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      root.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).with(priority: .defaultLow),
      root.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30)
    ])
    return root
  }()

}

private extension NSLayoutConstraint {
  func with(priority: UILayoutPriority) -> NSLayoutConstraint {
    self.priority = priority
    return self
  }
}
