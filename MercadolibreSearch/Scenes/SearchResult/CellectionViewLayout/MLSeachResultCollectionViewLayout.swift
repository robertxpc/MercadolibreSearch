//
//  MLSeachResultCollectionViewLayout.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 24-04-21.
//

import UIKit

class MLSeachResultCollectionViewLayout: UICollectionViewFlowLayout {

    let defaultHeight: CGFloat = 140
    let minWidth: CGFloat = 320

    override func prepare() {
        self.configLayout()
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        self.configLayout()
        return true
    }

    func configLayout() {
        minimumLineSpacing = 6
        minimumInteritemSpacing = 2
        scrollDirection = .vertical
        itemSize = CGSize(width: minWidth, height: defaultHeight)
        if let collectionView = self.collectionView {
            let colums = CGFloat(Int(collectionView.frame.width / minWidth))
            let cellWidth = (collectionView.frame.width - ((1 + colums) * (minimumInteritemSpacing + 1))) / colums
            itemSize = CGSize(width: cellWidth, height: defaultHeight)
        }
    }
}
