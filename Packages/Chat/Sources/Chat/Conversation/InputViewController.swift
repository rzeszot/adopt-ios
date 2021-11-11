import UIKit

class InputViewController: UIViewController {

  @objc private func sendAction() {
    guard !textView.text.isEmpty else { return }
    print("send")
  }

  // MARK: -

  private lazy var contentView: UIView = {
    let contentView = UIView()
    contentView.backgroundColor = .secondarySystemBackground

    view.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
      contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      contentView.topAnchor.constraint(equalTo: view.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).set(priority: UILayoutPriority(999)),
      contentView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])

    return contentView
  }()

  private lazy var sendButton: UIButton = {
    let sendButton = UIButton(type: .custom)
    sendButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
    sendButton.configuration = .borderless()
    sendButton.configuration?.contentInsets = .zero
    sendButton.configuration?.image = UIImage(systemName: "arrow.up.circle.fill")
    sendButton.contentVerticalAlignment = .fill

    contentView.addSubview(sendButton)
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      sendButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      sendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      sendButton.heightAnchor.constraint(equalToConstant: 42),
      sendButton.heightAnchor.constraint(equalTo: sendButton.widthAnchor)
    ])

    return sendButton
  }()

  private lazy var textView: UITextView = {
    let textView = ChatTextView()
    textView.font = .preferredFont(forTextStyle: .body)
    textView.backgroundColor = .tertiarySystemBackground
    textView.layer.cornerRadius = 5
    textView.delegate = self
    textView.placeholderLabel.text = "Message..."

    contentView.addSubview(textView)
    textView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
      textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])

    return textView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    updateSendButtonStateIfNeeded()
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .secondarySystemBackground

    _ = contentView
    _ = sendButton
    _ = textView
  }

  override func resignFirstResponder() -> Bool {
    textView.resignFirstResponder() || super.resignFirstResponder()
  }
}

extension InputViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    textView.setNeedsLayout()
    updateSendButtonStateIfNeeded()
  }

  private func updateSendButtonStateIfNeeded() {
    let image = UIImage(systemName: "arrow.up.circle" + (textView.text.isEmpty ? "" : ".fill"))
    sendButton.configuration?.image = image
  }
}

extension NSLayoutConstraint {
  func set(priority: UILayoutPriority) -> Self {
    self.priority = priority
    return self
  }
}
