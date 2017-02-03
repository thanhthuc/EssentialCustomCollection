//
//  EssentialLayout.swift
//  EssentialCustomCollection
//
//  Created by Nguyen Thanh Thuc on 08/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit



protocol EssentialLayoutDelegate: class {
   func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
   func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
   // 1
   var photoHeight: CGFloat = 0.0
   
   //2
   override func copy(with zone: NSZone? = nil) -> Any {
      
      let copy = super.copy(with: zone) as! PinterestLayoutAttributes
      copy.photoHeight = photoHeight
      
      return copy
   }
   
   //3
   override func isEqual(_ object: Any?) -> Bool {
      if let attributes = object as? PinterestLayoutAttributes {
         if( attributes.photoHeight == photoHeight  ) {
            return super.isEqual(object)
         }
      }
      return false
   }
   
}

class EssentialLayout: UICollectionViewFlowLayout {
   
   weak var delegate: EssentialLayoutDelegate!
   
   // 2
   var numberOfColumns = 2
   var cellPadding: CGFloat = 6.0
   
   // 3 attribute to calculate
   private var cache = [UICollectionViewLayoutAttributes]()
   
   // 4 calculate content height and width of collection view
   private var contentHeight: CGFloat = 0
   private var contentWidth: CGFloat {
      let inset = collectionView?.contentInset
      let width = (collectionView?.bounds.width)! - ((inset?.right)! + (inset?.left)!)
      return width
   }
   
   //NOW GO TO MAIN THING, CALCULATE attribute for every item
   override func prepare() {
      
      if cache.isEmpty {
         let columnWidth = contentWidth / CGFloat(numberOfColumns)
         var xOffset = [CGFloat]()
         
         //CALCULATE for xOffset increase
         for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
         }
         
         //yOffset
         var column = 0
         var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
         
         //3 This loops through all the items in the first section, as
         // this particular layout has only one section.
         for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            //4
            let width = columnWidth - cellPadding * 2
            let photoHeight = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
            let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
            let height = cellPadding + photoHeight + annotationHeight + cellPadding
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            //5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            //6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column >= (numberOfColumns - 1) ? 0: (column + 1)
         }
      }
   }
   
   override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
   }
   
   override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      var layoutAttributes = [UICollectionViewLayoutAttributes]()
      for attributes in cache {
         if attributes.frame.intersects(rect) {
            layoutAttributes.append(attributes)
         }
      }
      return layoutAttributes
   }
   
   
   
}
