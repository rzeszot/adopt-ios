//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, FilterHeaderViewDelegate {

    // MARK: -

    var model: FiltersModel!

    // MARK: -

    @IBOutlet
    var collectionView: UICollectionView!

    @IBOutlet
    var coverView: UIView!

    // MARK: -

    @IBAction
    func applyAction() {
        print("apply")
    }

    // MARK: -

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let padding = coverView.bounds.height - view.safeAreaInsets.bottom

        collectionView.contentInset.bottom = padding
        collectionView.verticalScrollIndicatorInsets.bottom = padding
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        model.groups.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.groups[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath)
        if let cell = cell as? FilterItemCell {
            cell.configure(item: model[indexPath])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { fatalError() }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)

        if let header = header as? FilterHeaderView {
            header.configure(item: model[indexPath.section])
            header.tag = indexPath.section
            header.delegate = self
        }

        return header
    }

    // MARK: - FilterHeaderViewDelegate

    func filterHeaderViewDidTapClear(_ view: FilterHeaderView) {
        let group = model[view.tag]

        print("clear \(group)")
    }

    // MARK: - UICollectionViewDelegate

}

private extension FiltersModel {
    subscript(_ indexPath: IndexPath) -> Group.Item {
        groups[indexPath.section].items[indexPath.row]
    }

    subscript(_ index: Int) -> Group.Meta {
        groups[index].meta
    }
}
