//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class BasicAuthViewController: UIViewController {

    // MARK: -

    var coordinator: BasicAuth.Coordinator!

    // MARK: -

    func use(_ vc: UIViewController) {
        if let old = children.first {
            old.willMove(toParent: nil)
            addChild(vc)

            view.inject(vc.view)

            UIView.transition(from: old.view, to: vc.view, duration: 0.5, options: .transitionCrossDissolve, completion: { _ in
                old.removeFromParent()
                vc.didMove(toParent: self)
            })
        } else {
            addChild(vc)
            view.inject(vc.view)
            vc.didMove(toParent: self)
        }
    }

}

private extension UIView {
    func inject(_ child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        addSubview(child)
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: child.leftAnchor),
            rightAnchor.constraint(equalTo: child.rightAnchor),
            topAnchor.constraint(equalTo: child.topAnchor),
            bottomAnchor.constraint(equalTo: child.bottomAnchor)
        ])
    }
}
