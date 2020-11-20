//
//  FadeLayout.swift
//  PomodoroApp
//
//  Created by Yaroslav on 19.11.2020.
//

import UIKit

class FadingLayout: UICollectionViewFlowLayout,UICollectionViewDelegateFlowLayout {

    private let fadingDistance: CGFloat = 60
    private let fadeFactor: CGFloat = 0.017
    private let cellHeight : CGFloat = 80

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(scrollDirection:UICollectionView.ScrollDirection) {
        super.init()
        self.scrollDirection = scrollDirection

    }

    override func prepare() {
        setupLayout()
        super.prepare()
    }

    func setupLayout() {
        self.itemSize = CGSize(width: 2,height:80)
        self.minimumLineSpacing = 15
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    func scrollDirectionOver() -> UICollectionView.ScrollDirection {
        return UICollectionView.ScrollDirection.vertical
    }
    //this will fade both top and bottom but can be adjusted
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesSuper: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect)!
        if let attributes = NSArray(array: attributesSuper, copyItems: true) as? [UICollectionViewLayoutAttributes]{
            var visibleRect = CGRect()
            visibleRect.origin = collectionView!.contentOffset
            visibleRect.size = collectionView!.bounds.size
            for attrs in attributes {
                if attrs.frame.intersects(rect) {
                    attrs.alpha = 1
                    let distanceToEdge = min(abs(visibleRect.minX - attrs.center.x), abs(visibleRect.maxX - attrs.center.x))
                    if distanceToEdge <= fadingDistance {
                        attrs.alpha = distanceToEdge * fadeFactor
                    }

                }
            }
            return attributes
        } else {
            return nil
        }
    }
    //appear and disappear at 0
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: itemIndexPath)! as UICollectionViewLayoutAttributes
        attributes.alpha = 0
        return attributes
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: itemIndexPath)! as UICollectionViewLayoutAttributes
        attributes.alpha = 0
        return attributes
    }
}
