//
//  EndingBellController.swift
//  InsightMind
//
//  Created by Bartek on 4/29/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
import AVFoundation

protocol EndingBellSoundSelection {
    func didSelectEndingBell(soundNamePlayer: String)
}

class EndingBellController: UIViewController {
   
    
    var endingBellSoundDelegate: EndingBellSoundSelection?
   
   
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
    var audioPlayer = AVAudioPlayer()
    var chosenSound = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    
        //behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 30)
   //     behavior = MSCollectionViewPeekingBehavior(cellSpacing: 20)
      
        collectionView.configureForPeekingBehavior(behavior: behavior)
       
        
        
    }
    
    //MARK: - Nav Bar button items
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        //Here what I am doing is matching up the name of the sound with the variable and passing it onto the second screen
        endingBellSoundDelegate?.didSelectEndingBell(soundNamePlayer: chosenSound)
       
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            print(indexPath!)
            playSound(soundName: chosenSound)
        }
      //  playSound(soundName: chosenSound)
    }
    //Plays sound when item is tapped, Will have to add PageDidEndDecelerating
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    endingBellSoundDelegate?.didSelectEndingBell(soundNamePlayer: String(indexPath.row))
        chosenSound = String(indexPath.row)
          playSound(soundName: chosenSound)
           print(chosenSound)
       }
    
}

extension EndingBellController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
   
}

func playSound(soundName: String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
}
