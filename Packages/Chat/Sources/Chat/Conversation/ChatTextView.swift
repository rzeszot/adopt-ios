import UIKit

class ChatTextView: UITextView {

  override var font: UIFont? {
    didSet {
      placeholderLabel.font = font
    }
  }

  override var textColor: UIColor? {
    didSet {
      placeholderLabel.textColor = textColor?.withAlphaComponent(0.5)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    heightConstraint.constant = contentSize.height
    updatePlaceholderVisibilityIfNeeded()
  }

  // MARK: - UIKeyInput

  override func insertText(_ text: String) {
    super.insertText(text)
    updatePlaceholderVisibilityIfNeeded()
  }

  override func deleteBackward() {
    super.deleteBackward()
    updatePlaceholderVisibilityIfNeeded()
  }

  private func updatePlaceholderVisibilityIfNeeded() {
    placeholderLabel.isHidden = !text.isEmpty
    setNeedsUpdateConstraints()
  }

  // MARK: -

  override func updateConstraints() {
    super.updateConstraints()

    constraints
      .first { $0.firstAnchor == placeholderLabel.leadingAnchor }?
      .constant = caretRect(for: beginningOfDocument).minX
  }

  // MARK: -

  lazy var placeholderLabel: UILabel = {
    let label = UILabel()
    label.font = font
    label.textColor = textColor?.withAlphaComponent(0.5)
    label.setContentHuggingPriority(.required, for: .vertical)

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])

    return label
  }()

  private lazy var heightConstraint: NSLayoutConstraint = {
    let constraint = heightAnchor.constraint(equalToConstant: 0)
    constraint.priority = .defaultHigh
    addConstraint(constraint)
    return constraint
  }()

}
