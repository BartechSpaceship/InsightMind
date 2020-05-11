//
//  CollectionViewCellAmbientSound.swift
//  InsightMind
//
//  Created by Bartek on 5/10/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import UIKit

class CollectionViewCellAmbientSound: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "CollectionViewCellAmbientSound"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        
        return UINib(nibName: "CollectionViewCellAmbientSound", bundle: nil)
    }

}
