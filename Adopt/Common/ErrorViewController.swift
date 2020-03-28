//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

public class ErrorViewController: UIViewController {

    // MARK: -

    private var error: Error?

    convenience init(error: Error?) {
        self.init()
        self.error = error
    }

    // MARK: -

    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var imageView: UIImageView!

    public override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.text = "Something went wrong"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        subtitleLabel = UILabel()
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.text = error?.localizedDescription ?? "(unknown)"
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0

        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true

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
