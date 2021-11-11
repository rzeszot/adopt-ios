import UIKit

class InputViewController: UIViewController {

  private var contentView: UIView!
  private var textView: UITextView!
  private var sendButton: UIButton!

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemPink

    contentView = UIView()
    contentView.backgroundColor = .systemBackground
    view.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
      contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      contentView.topAnchor.constraint(equalTo: view.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).set(priority: .defaultLow),
      contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
    ])

    sendButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in print("send") }))
    sendButton.configuration = .plain()
    sendButton.configuration?.image = UIImage(systemName: "paperplane.fill")
    contentView.addSubview(sendButton)
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      sendButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      sendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ])

    textView = UITextView()
    textView.isEditable = true
    textView.text = "hello"
    textView.backgroundColor = .systemPink
    contentView.addSubview(textView)
    textView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
      textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }

  override func resignFirstResponder() -> Bool {
    textView.resignFirstResponder() || super.resignFirstResponder()
  }
}

extension NSLayoutConstraint {
  func set(priority: UILayoutPriority) -> Self {
    self.priority = priority
    return self
  }
}
