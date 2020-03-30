//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

@IBDesignable
class AnimalListEntryCell: UICollectionViewCell {

    // MARK: -

    @IBOutlet
    var titleLabel: UILabel!

    @IBOutlet
    var subtitleLabel: UILabel!

    @IBOutlet
    var imageView: UIImageView!

    // MARK: -

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        contentView.layer.cornerRadius = 10

        layer.cornerRadius = 10
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = .zero
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.shadowColor = UIColor.secondaryLabel.cgColor
    }

    // MARK: -

    typealias Item = AnimalsListModel.Animal

    private var source: URL?

    func configure(item: Item) {
        titleLabel.text = item.name

//        source = item.thumbnail

        if let source = source {
            let session = URLSession.shared
            let task = session.dataTask(with: source) { [weak self] data, _, _ in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }

                DispatchQueue.main.async {
                    if self?.source == item.thumbnail {
                        self?.imageView.image = image
                    }
                }
            }
            task.resume()
        } else {
            imageView.image = nil
        }
    }

}
