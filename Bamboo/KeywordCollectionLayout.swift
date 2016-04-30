//
//  KeywordCollectionLayout.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 4. 30..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

class CustomLayout: UICollectionViewFlowLayout {
    var numberOfItemsPerRow: Int = 2 {
        didSet {
            invalidateLayout()
        }
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        if let collectionView = self.collectionView {
            var newItemSize = itemSize
            
            // Always use an item count of at least 1
            let itemsPerRow = CGFloat(max(numberOfItemsPerRow, 1))
            
            // Calculate the sum of the spacing between cells
            let totalSpacing = minimumInteritemSpacing * (itemsPerRow - 1.0)
            
            // Calculate how wide items should be
            newItemSize.width = (collectionView.bounds.size.width - totalSpacing) / itemsPerRow
            
            // Use the aspect ratio of the current item size to determine how tall the items should be
            if itemSize.height > 0 {
                let itemAspectRatio = itemSize.width / itemSize.height
                newItemSize.height = newItemSize.width / itemAspectRatio + 30.0
            }
            
            // Set the new item size
            itemSize = newItemSize
        }
    }
}