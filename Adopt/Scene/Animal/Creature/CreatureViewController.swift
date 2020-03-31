//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import Cache

class CreatureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: -

    var select: (() -> Void)!
    var model: Creature.Model!

    // MARK: -

    @IBOutlet
    var collectionView: UICollectionView!

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.create()
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.animals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? RecentEntryCell {
            cell.configure(item: model.animals[indexPath.row])
        }
        return cell
    }

    // MARK: - UICollectionViewDelegate

    let cache = Cache<URL, UIImage>()

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? RecentEntryCell  else { return }
        cell.imageView.image = nil

        guard let url = model.animals[indexPath.row].thumbnail else { return }

        if let image = cache[url] {
            cell.imageView.image = image
        } else {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data,
                    let image = UIImage(data: data) else { return }

                DispatchQueue.main.async {
                    self.cache[url] = image
                    (collectionView.cellForItem(at: indexPath) as? RecentEntryCell)?.imageView.image = image
                }
            }.resume()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select()
    }

}

private extension UICollectionViewCompositionalLayout {
    static func create() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            return NSCollectionLayoutSection.animals
        }

        return layout
    }
}

private extension NSCollectionLayoutSection {
    static var animals: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        return section
    }
}

extension RecentEntryCell {
    func configure(item: Creature.Animal) {
        titleLabel.text = item.name
    }
}
