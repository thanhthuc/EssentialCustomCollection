//
//  ViewController.swift
//  EssentialCustomCollection
//
//  Created by Nguyen Thanh Thuc on 08/12/2016.
//  Copyright © 2016 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   let photos = Photo.allPhoto()
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      collectionView.delegate = self
      collectionView.dataSource = self
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}




extension ViewController: UICollectionViewDataSource {
   
   
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
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

extension ViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 140, height: 140)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
   }
}
