//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

public class ErrorViewController: UIViewController {

    convenience init(error: Error?) {
        self.init()
    }

    // MARK: -

    var titleLabel: UILabel!
    var imageView: UIImageView!

    public override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.text = "Something went wrong"
        titleLabel.textAlignment = .center

        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill"))
        imageView.tintColor = UIColor.systemYellow
        imageView.contentMode = .scaleAspectFit

        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

}
