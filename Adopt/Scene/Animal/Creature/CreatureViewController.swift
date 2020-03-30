//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

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
        (cell as? RecentEntryCell)?.titleLabel.text = model.animals[indexPath.row].name
        return cell
    }

    // MARK: - UICollectionViewDelegate

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
