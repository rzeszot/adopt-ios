//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class FiltersDiffableDataSource: UICollectionViewDiffableDataSource<String, String> {

    convenience init(model: FiltersModel, collectionView: UICollectionView) {
        self.init(collectionView: collectionView) { (collectionView, indexPath, _) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath)
            (cell as? FilterItemCell)?.configure(item: model.groups[indexPath.section].items[indexPath.row])
            return cell
        }

        supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            (header as? FilterHeaderView)?.configure(item: model.groups[indexPath.section].meta)
            return header
        }
    }
}

class FiltersViewController: UIViewController, UICollectionViewDelegate {

    // MARK: -

    @IBOutlet
    var collectionView: UICollectionView!

    @IBOutlet
    var coverView: UIView!

    // MARK: -

    var model: FiltersModel!

    var source: UICollectionViewDiffableDataSource<String, String>!

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        source = FiltersDiffableDataSource(model: model, collectionView: collectionView)

        collectionView.dataSource = source

        var snapshot = NSDiffableDataSourceSnapshot<String, String>()

        for (index, group) in model.groups.enumerated() {
            snapshot.appendSections(["group-\(index)"])
            snapshot.appendItems(group.items.map { $0.id })
        }

        source.apply(snapshot, animatingDifferences: false, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let padding = coverView.bounds.height - view.safeAreaInsets.bottom

        collectionView.contentInset.bottom = padding
        collectionView.verticalScrollIndicatorInsets.bottom = padding
    }

    // MARK: - UICollectionViewDelegate

}

class AlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        for attribute in attributes ?? [] {
            guard attribute.representedElementCategory == UICollectionView.ElementCategory.cell else { continue }

            if attribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            attribute.frame.origin.x = leftMargin

            leftMargin += attribute.frame.width + minimumInteritemSpacing
            maxY = max(attribute.frame.maxY, maxY)
        }

        return attributes
    }
}
