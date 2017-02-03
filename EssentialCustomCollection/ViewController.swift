//
//  ViewController.swift
//  EssentialCustomCollection
//
//  Created by Nguyen Thanh Thuc on 08/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   let photos = Photo.allPhoto()
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      collectionView.delegate = self
      collectionView.dataSource = self
      
      if let layout = collectionView?.collectionViewLayout as? EssentialLayout {
         layout.delegate = self
      }
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
}


extension ViewController: UICollectionViewDataSource {
   
   
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 2
   }
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return photos.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotosCollectionViewCell
      cell.photo = photos[indexPath.row]
      return cell
   }
}

extension ViewController: UICollectionViewDelegate {
   
}


extension ViewController : EssentialLayoutDelegate {
   // 1
   func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath,
                       withWidth width: CGFloat) -> CGFloat {
      let photo = photos[indexPath.item]
      let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
      let rect = AVMakeRect(aspectRatio: photo.image!.size, insideRect: boundingRect)
      return rect.size.height
   }
   
   // 2
   func collectionView(collectionView: UICollectionView,
                       heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
      let annotationPadding = CGFloat(4)
      let annotationHeaderHeight = CGFloat(17)
      let photo = photos[indexPath.item]
      let font = UIFont(name: "AvenirNext-Regular", size: 10)!
      let commentHeight = photo.heightForComment(font: font, width: width)
      let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
      
      return height
   }
}
