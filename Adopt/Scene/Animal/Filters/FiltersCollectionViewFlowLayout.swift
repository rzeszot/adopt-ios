//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import UIKit

class FiltersCollectionViewFlowLayout: UICollectionViewFlowLayout {

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
