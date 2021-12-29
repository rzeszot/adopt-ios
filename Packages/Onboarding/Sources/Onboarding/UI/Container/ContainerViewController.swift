import UIKit

class ContainerViewController: UIViewController, UIPageViewControllerDataSource {

  var viewModel: ContainerViewModel? {
    didSet {
      let vc = viewModel?.steps.first.map(build(for:))
      pageViewController.setViewControllers([vc!], direction: .forward, animated: false)

      _ = logoImageView
      _ = bottomView
      _ = pageViewController
    }
  }

  // MARK: -

  @objc private func skipAction() {
    print("skip")
  }

  @objc private func nextAction() {
    print("next")
  }

  // MARK: - UIPageViewControllerDataSource

  func pageViewController(_ : UIPageViewController, viewControllerAfter vc: UIViewController) -> UIViewController? {
    build(at: vc.index + 1)
  }

  func pageViewController(_ : UIPageViewController, viewControllerBefore vc: UIViewController) -> UIViewController? {
    build(at: vc.index - 1)
  }

  // MARK: -

  func build(at index: Int) -> UIViewController? {
    viewModel?.steps[safe: index].map(build(for:))
  }

  func build(for viewModel: StepViewModel) -> UIViewController {
    let vc = StepViewController()
    vc.viewModel = viewModel
    return vc
  }

  // MARK: -

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    var insets = pageViewController.additionalSafeAreaInsets
    insets.top = logoImageView.bounds.height
    insets.bottom = bottomView.bounds.height
    pageViewController.additionalSafeAreaInsets = insets
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.insetsLayoutMarginsFromSafeArea = true
    view.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    bottomView.skipButton.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
    bottomView.nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
  }

  private lazy var logoImageView: UIImageView = {
    let root = UIImageView()
    root.backgroundColor = .systemRed

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
      root.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
      root.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      root.heightAnchor.constraint(equalToConstant: 100)
    ])
    return root
  }()

  private lazy var bottomView: BottomView = {
    let root = BottomView()

    view.addSubview(root)
    root.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
      root.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
      root.heightAnchor.constraint(equalToConstant: 50),
      root.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
    ])
    return root
  }()

  private lazy var pageViewController: UIPageViewController = {
    let root = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    root.view.layoutMargins = view.layoutMargins
    root.view.backgroundColor = .blue

    addChild(root)
    view.addSubview(root.view)
    view.sendSubviewToBack(root.view)
    root.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      root.view.topAnchor.constraint(equalTo: view.topAnchor),
      root.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      root.view.leftAnchor.constraint(equalTo: view.leftAnchor),
      root.view.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
    root.didMove(toParent: self)
    return root
  }()

}

private extension UIViewController {
  var index: Int {
    set {
      view.tag = newValue
    }
    get {
      view.tag
    }
  }
}

private extension Array {
  subscript(safe index: Index) -> Element? {
    guard indices.contains(index) else { return nil }
    return self[index]
  }
}
