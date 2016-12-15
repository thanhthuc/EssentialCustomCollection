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

class EssentialLayout: UICollectionViewFlowLayout {
    
    weak var delegate: EssentialLayoutDelegate?
    
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
        
        let widthCell = 0
        let heightCell = 0
        
        
        
    }
    
}
