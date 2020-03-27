//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit
import Combine
import Faker

class SearchViewController: UIViewController, UICollectionViewDelegate, UISearchResultsUpdating, SearchHeaderViewDelegate {

    // MARK: -

    @IBOutlet
    var collectionView: UICollectionView!

    @IBOutlet
    var bottomPadding: NSLayoutConstraint!

    // MARK: -

    var model: Model = .init()
    var source: UICollectionViewDiffableDataSource<String, String>!

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        source = UICollectionViewDiffableDataSource<String, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, _) -> UICollectionViewCell? in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recent", for: indexPath)
//                (cell as? SearchRecentCell)?.titleLabel.text = self.model.recent.items[indexPath.row].name
                return cell

            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "history", for: indexPath)
                (cell as? SearchHistoryCell)?.titleLabel.text = self.model.history.items[indexPath.row].name
                return cell

            default:
                fatalError()
            }
        })

        source.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            (header as? SearchHeaderView)?.titleLabel.text = ["Ostatnio oglądane", "Niedawne wyszukania"][indexPath.section]
            return header
        }

        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["recent"])
        snapshot.appendItems(model.recent.items.map { $0.id.uuidString })
        snapshot.appendSections(["history"])
        snapshot.appendItems(model.history.items.map { $0.id.uuidString })
        source.apply(snapshot)

        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.create(for: model)
        collectionView.dataSource = source

        cancellable = show.merge(with: hide).sink { height in
            self.bottomPadding.constant = height

            UIView.animate(withDuration: 0.3, animations: self.view.layoutIfNeeded)
        }

    }

    // MARK: -

    struct Model {

        struct Recent {
            struct Item {
                let id: UUID = .init()
                let name: String
            }

            let items: [Item]
        }

        struct History {
            struct Item {
                 let id: UUID = .init()
                 let name: String
             }

            let items: [Item]
        }

        let recent: Recent
        let history: History

        init() {
            recent = Recent(items: (0...10).map { _ in Recent.Item(name: Faker.creature.dog.name) })
            history = History(items: (0...10).map { _ in History.Item(name: Faker.creature.dog.name) })
        }
    }

    // MARK: -

    // MARK: -

    private let show = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
        .map { $0.cgRectValue.height }

    private let hide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat(0) }

    private var cancellable: AnyCancellable?

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if let view = view as? SearchHeaderView {
            view.delegate = self
        }
    }

    // MARK: - SearchHeaderViewDelegate

    func searchHeaderViewDidTapClean(_ view: SearchHeaderView) {
        // Czy na pewno chcesz wyczyścić listę niedawnych wyszukiwań?
        let alert = UIAlertController(title: "Czy na pewno chcesz wyczyślić listę ostatnio przeglądanych elementów?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Wyczyść wszystko", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Anuluj", style: .cancel, handler: nil))

        present(alert, animated: true)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        print("seach \(text)")
    }

}

private extension UICollectionViewCompositionalLayout {
    static func create(for model: SearchViewController.Model) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return NSCollectionLayoutSection.history
            case 1:
                return NSCollectionLayoutSection.recent
            default:
                return nil
            }
        }

        return layout
    }
}

private extension NSCollectionLayoutSection {
    static var history: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem.header]
        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0)

        return section
    }

    static var recent: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem.header]
        section.orthogonalScrollingBehavior = .none

        return section
    }
}

private extension NSCollectionLayoutBoundarySupplementaryItem {
    static var header: NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return item
    }
}
