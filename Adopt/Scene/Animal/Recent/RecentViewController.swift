//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController, UICollectionViewDelegate, UISearchResultsUpdating {

    // MARK: -

    var category: ((Recent.Category) -> Void)!
    var details: (() -> Void)!

    // MARK: -

    @IBOutlet
    var collectionView: UICollectionView!

    // MARK: -

    var model: Recent.Model!
    var source: UICollectionViewDiffableDataSource<String, String>!

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        source = UICollectionViewDiffableDataSource<String, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, _) -> UICollectionViewCell? in

            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath)
                (cell as? RecentCategoryCell)?.titleLabel.text = self.model.categories[indexPath.row].name
                (cell as? RecentCategoryCell)?.subtitleLabel.text = String(self.model.categories[indexPath.row].count)
                return cell

            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animal", for: indexPath)
                (cell as? RecentEntryCell)?.configure(item: self.model.animals[indexPath.row])
                return cell

            default:
                fatalError()
            }
        })

        source.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            (header as? RecentHeaderView)?.titleLabel.text = ["Kategoria", "Najnowsze"][indexPath.section]
            return header
        }

        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["categories"])
        snapshot.appendItems(model.categories.map { $0.id })
        snapshot.appendSections(["animals"])
        snapshot.appendItems(model.animals.map { $0.id })
        source.apply(snapshot)

        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.create(for: model)
        collectionView.dataSource = source
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let xxx = model.categories[indexPath.row]
            category(xxx)
        } else {
            details()
        }
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        print("seach \(text)")
    }

}

private extension UICollectionViewCompositionalLayout {
    static func create(for model: Recent.Model) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return NSCollectionLayoutSection.categories
            case 1:
                return NSCollectionLayoutSection.animals
            default:
                return nil
            }
        }

        return layout
    }
}

private extension NSCollectionLayoutSection {
    static var categories: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.42), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem.header]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        return section
    }

    static var animals: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem.header]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        return section
    }
}

private extension NSCollectionLayoutBoundarySupplementaryItem {
    static var header: NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
