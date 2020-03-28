//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

public class LoadingViewController: UIViewController {

    var activityView: UIActivityIndicatorView!

    public override func loadView() {
        view = UIView()

        activityView = UIActivityIndicatorView(style: .medium)

        view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityView.startAnimating()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityView.stopAnimating()
    }

}
