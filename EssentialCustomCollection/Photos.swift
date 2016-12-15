//
//  Photos.swift
//  EssentialCustomCollection
//
//  Created by Nguyen Thanh Thuc on 08/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

class Photo: NSObject {
    
    //the destination is get photo with type is Photos
    var caption: String?
    var comment: String?
    var image: UIImage?
    
    class func allPhoto() -> [Photo] {
        let url = Bundle.main.url(forResource: "Photos", withExtension: "plist")
        let photosFromUrl = NSArray(contentsOf: url!)
        
        var photos: [Photo] = []
        for dict in photosFromUrl! {
            let photo = Photo(dict: dict as! NSDictionary)
            photos.append(photo)
        }
        return photos
    }
    
    init(dict: NSDictionary) {
        self.comment = dict["Caption"] as? String
        self.caption = dict["Comment"] as? String
        let nameImage = dict["Photo"] as? String
        self.image = UIImage(named: nameImage!)
    }
}
