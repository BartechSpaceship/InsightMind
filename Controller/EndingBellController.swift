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
    func didSelectEndingBell(soundNamePlayer: String, soundNameLabel: String)
}

class EndingBellController: UIViewController {
   
    
    var endingBellSoundDelegate: EndingBellSoundSelection?
    var indexPathNoDecimal = 0
    
   
   
    
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
       
    
    var behavior = MSCollectionViewPeekingBehavior()
  //  var audioPlayer = AVAudioPlayer()
    var chosenSound = ""
    var chosenSoundLabel: Any? = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    //If this is changed then you have to change the center point of the app "Current Index"
//        behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 40)
//        behavior = MSCollectionViewPeekingBehavior(cellSpacing: 30)
      
        collectionView.configureForPeekingBehavior(behavior: behavior)
        
        
    }
    

    
    //MARK: - Nav Bar button items
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        //Protocol to move data back to MainScreen
        //Had to change chosenSoundLabel as! string because of failure of stopping sound on cancel and save button
        endingBellSoundDelegate?.didSelectEndingBell(soundNamePlayer: chosenSound,soundNameLabel: chosenSoundLabel as! String)
        if chosenSoundLabel == nil {
            player.stop()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        
        if chosenSoundLabel == nil {
            player.stop()
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func repeatBellButton(_ sender: UIButton) {
        //all 3 buttons will be connected to this, when clicked on it will be highlighted and the circle will appear around them
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
    //MARK: - Select Sound Here
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let currentIndex = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
        let indexPathNoDecimal = String(format: "%.0f", currentIndex * 1.1)
        
      //  chosenSound = indexPathNoDecimal
        playSound(soundName: indexPathNoDecimal)
        print(indexPathNoDecimal)
        
//Picks the Sound for the delegate to move it to MainScreenController
        switch indexPathNoDecimal {
        case "0":
           chosenSoundLabel = "BASU"
            chosenSound = "0"
        case "1":
            chosenSoundLabel = "Number Two"
            chosenSound = "1"
        case "2":
            chosenSoundLabel = "Gong"
            chosenSound = "2"
        case "3":
            chosenSoundLabel = "Number Four"
            chosenSound = "3"
        case "4":
            chosenSoundLabel = "Number Five"
            chosenSound = "4"
        case "5":
            chosenSoundLabel = "Number Six"
            chosenSound = "5"
        case "6":
            chosenSoundLabel = "Number Seven"
            chosenSound = "6"
        case "7":
            chosenSoundLabel = "Number Eight"
            chosenSound = "7"
        case "8":
            chosenSoundLabel = "Number Nine"
            chosenSound = "8"
        default:
            playSound(soundName: "0")
        }
    
       
    
    
    }
    
    //Plays sound when item is tapped, Will have to add PageDidEndDecelerating
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    endingBellSoundDelegate?.didSelectEndingBell(soundNamePlayer: String(indexPath.row))
        
        chosenSound = String(indexPath.row)
         playSound(soundName: chosenSound)
               print(chosenSound)
        switch chosenSound {
               case "0":
                  chosenSoundLabel = "BASU"
                   chosenSound = "0"
               case "1":
                   chosenSoundLabel = "Number Two"
                   chosenSound = "1"
               case "2":
                   chosenSoundLabel = "Gong"
                   chosenSound = "2"
               case "3":
                   chosenSoundLabel = "Number Four"
                   chosenSound = "3"
               case "4":
                   chosenSoundLabel = "Number Five"
                   chosenSound = "4"
               case "5":
                   chosenSoundLabel = "Number Six"
                   chosenSound = "5"
               case "6":
                   chosenSoundLabel = "Number Seven"
                   chosenSound = "6"
               case "7":
                   chosenSoundLabel = "Number Eight"
                   chosenSound = "7"
               case "8":
                   chosenSoundLabel = "Number Nine"
                   chosenSound = "8"
               default:
                   playSound(soundName: "0")
               }
           
        
                
       
        
       }
    
}


extension EndingBellController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
       
    }
}
var player: AVAudioPlayer!

func playSound(soundName: String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
}
