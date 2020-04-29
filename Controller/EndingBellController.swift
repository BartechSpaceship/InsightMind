//
//  EndingBellController.swift
//  InsightMind
//
//  Created by Bartek on 4/29/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class EndingBellController: UIViewController {
   
   
    var imageArray: [UIImage] = [
          UIImage(named: "0")!,
          UIImage(named: "1")!,
          UIImage(named: "2")!,
          UIImage(named: "3")!,
          UIImage(named: "4")!,
          UIImage(named: "5")!,
          UIImage(named: "6")!,
          UIImage(named: "7")!,
          UIImage(named: "8")!
          
      ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var behavior = MSCollectionViewPeekingBehavior()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        //behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 30)
   //     behavior = MSCollectionViewPeekingBehavior(cellSpacing: 20)
      
        collectionView.configureForPeekingBehavior(behavior: behavior)
       
        
        
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        print("saved")
    }
    
    
    
}

extension EndingBellController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let images = imageArray[indexPath.row]
        cell.imageBell.image = images
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
           print(indexPath.row + 1)
       }
    
}

extension EndingBellController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
   
}



