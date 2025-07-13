//
//  CustomLayout.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit

final class CustomLayout: UICollectionViewLayout {
    var numberOfColumns = 2
    var cellPadding: CGFloat = 8

    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0

    private var width: CGFloat {
        collectionView?.bounds.width ?? 0
    }

    override var collectionViewContentSize: CGSize {
        CGSize(width: width, height: contentHeight)
    }

    override func prepare() {
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        contentHeight = 0

        let columnWidth = (width - CGFloat(numberOfColumns + 1) * cellPadding) / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * (columnWidth + cellPadding) + cellPadding)
        }
        var yOffset = [CGFloat](repeating: cellPadding, count: numberOfColumns)

        let itemCount = collectionView.numberOfItems(inSection: 0)
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: 0)
            let column = yOffset.firstIndex(of: yOffset.min() ?? 0) ?? 0

            let height: CGFloat
            if let delegate = collectionView.delegate as? CustomLayoutDelegate {
                height = delegate.collectionView(collectionView, heightForItemAt: indexPath, with: columnWidth)
            } else {
                height = 180
            }

            let frame = CGRect(
                x: xOffset[column],
                y: yOffset[column],
                width: columnWidth,
                height: height
            )
            let insetFrame = frame.insetBy(dx: 0, dy: 0)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            yOffset[column] = yOffset[column] + height + cellPadding
            contentHeight = max(contentHeight, yOffset[column])
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { $0.indexPath == indexPath }
    }
}

protocol CustomLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}
