//
//  AmbientViewController.swift
//  InsightMind
//
//  Created by Bartek on 5/9/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit
//
//@IBOutlet weak var ambientImage: UIImageView!
//   @IBOutlet weak var ambientLabel: UILabel!
class AmbientViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    var imageNames = [ "0", "1", "2", "3", "4", "5", "6", "7", "8"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CollectionViewCellAmbientSound.nib(), forCellWithReuseIdentifier: CollectionViewCellAmbientSound.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        
        
    }
    
    @IBAction func cancelNavButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveNavButton(_ sender: UIBarButtonItem) {

    }
    
}

extension AmbientViewController: UICollectionViewDelegate {//Delegate helps to pick up interaction with the cells
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
}

extension AmbientViewController: UICollectionViewDataSource {//tells howmany cells in a given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        imageArray.count
        return 20
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellAmbientSound.identifier, for: indexPath) as!  CollectionViewCellAmbientSound
        //This is the image that will show up in the cell
        cell.imageView.image = imageArray[indexPath.count]
//        cell.configure(with: UIImage(named: "1")!)
//        cell.ambientImage.image = imageArray[indexPath.item]
        return cell
    }
}

extension AmbientViewController: UICollectionViewDelegateFlowLayout {
    //margin and padding between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 131, height: 131)
    }
    
}
