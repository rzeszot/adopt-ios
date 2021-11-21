import UIKit

class HintView: UIView {

  lazy var imageView: UIImageView = {
    let root = UIImageView()

    addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.widthAnchor.constraint(equalTo: root.heightAnchor),
      root.widthAnchor.constraint(equalToConstant: 80),
      root.topAnchor.constraint(equalTo: topAnchor),
      root.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])

    return root
  }()

  lazy var titleLabel: UILabel = {
    let root = UILabel()
    root.font = .preferredFont(forTextStyle: .callout).withWeight(.bold)
    root.numberOfLines = 0
    root.textAlignment = .center
    root.setContentCompressionResistancePriority(.required, for: .vertical)

    addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: leftAnchor, constant: layoutMargins.left),
      root.rightAnchor.constraint(equalTo: rightAnchor, constant: -layoutMargins.right),
      root.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
      root.bottomAnchor.constraint(equalTo: bottomAnchor)

    ])

    return root
  }()

}
