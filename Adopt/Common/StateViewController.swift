//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

open class StateViewController<T>: UIViewController {

    // MARK: -

    public enum State<T> {
        case empty
        case loading
        case data(T)
        case error(Error?)
    }

    // MARK: -

    final var state: State<T> = .empty

    open func transform(_ state: State<T>) -> UIViewController {
        switch state {
        case .loading:
            return LoadingViewController()
        case .empty:
            return EmptyViewController()
        case .error(let error):
            return ErrorViewController(error: error)
        case .data:
            fatalError()
        }
    }

    // MARK: -

    public func change(_ state: State<T>, animated: Bool = false) {
        let new = transform(state)

        if let old = children.first {
            hide(old, animated: animated) { [weak self] in
                self?.show(new, animated: animated)
            }
        } else {
            show(new, animated: animated)
        }
    }

    // MARK: -

    private func hide(_ vc: UIViewController, animated: Bool, completion: @escaping () -> Void = {}) {
        precondition(children.contains(vc))

        vc.willMove(toParent: nil)

        UIView.animate(withDuration: 0.2, animations: {
            vc.view.alpha = 0
        }, completion: { _ in
            vc.view.removeFromSuperview()
            vc.removeFromParent()

            completion()
        })
    }

    private func show(_ vc: UIViewController, animated: Bool, completion: @escaping () -> Void = {}) {
        precondition(!children.contains(vc))

        addChild(vc)

        view.addSubview(vc.view)

        vc.view.translatesAutoresizingMaskIntoConstraints = false

        vc.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vc.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        vc.view.alpha = 0

        UIView.animate(withDuration: 0.2, animations: {
            vc.view.alpha = 1
        }, completion: { _ in
            vc.didMove(toParent: self)
            completion()
        })
    }

}
