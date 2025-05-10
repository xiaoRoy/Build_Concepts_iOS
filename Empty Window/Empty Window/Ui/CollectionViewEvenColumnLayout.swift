//
//  CollectionViewEvenColumnLayout.swift
//  Empty Window
//
//  Created by Jerry Li on 2025/5/6.
//

import UIKit

class CollectionViewEvenColumnDelegateLayout: NSObject,
    UICollectionViewDelegateFlowLayout
{
    private let numberOfItemsPerRow: Int
    init(numberOfItemsPerRow: Int) {
        self.numberOfItemsPerRow = numberOfItemsPerRow
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard
            let collectionViewFlowLayout = collectionViewLayout
                as? UICollectionViewFlowLayout
        else {
            return .zero
        }
        let numberOfRow = CGFloat(numberOfItemsPerRow)
        let totalSpacing =
            collectionViewFlowLayout.sectionInset.left
            + collectionViewFlowLayout.sectionInset.right
            + (numberOfRow - 1)
            * collectionViewFlowLayout.minimumInteritemSpacing
        let availableWidth = collectionView.bounds.width - totalSpacing
        let itemWidth = availableWidth / numberOfRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

