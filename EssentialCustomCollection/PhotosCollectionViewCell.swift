//
//  PhotosTableViewCell.swift
//  EssentialCustomCollection
//
//  Created by Nguyen Thanh Thuc on 08/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

@IBDesignable
class BorderView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    var photo: Photo? {
        
        didSet {
            self.image.image = photo!.image
            self.caption.text = photo!.caption
            self.comment.text = photo!.comment
         }
    }
    
    
    
}
