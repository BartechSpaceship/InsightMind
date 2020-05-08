//
//  SelectionController.swift
//  InsightMind
//
//  Created by Bartek on 4/11/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MSPeekCollectionViewDelegateImplementation


class MainScreenController: UIViewController{
    
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var soundChosenFromEndingBellController = ""
    var chosenSoundForStartingBell = ""
    
    
    
    @IBOutlet weak var collectionViewStartingBell: UICollectionView!
    @IBOutlet weak var durationTimer: UILabel!
    @IBOutlet weak var endingBellAssistingLabel: UILabel!
    @IBOutlet weak var repeatBellButtonOneStarting: UIButton!
    @IBOutlet weak var repeatBellButtonTwoStarting: UIButton!
    @IBOutlet weak var repeatBellButtonThreeStarting: UIButton!
    
    
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
       var imageArrayBellNames: [String] = [
           "Basu",
           "monkey",
           "water",
           "bell",
           "Shek wes",
           "Kanye Wes",
           "Sponge",
           "Bob",
           "mike"
       ]
    
    var behavior = MSCollectionViewPeekingBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewStartingBell.delegate = self
        collectionViewStartingBell.dataSource = self
        collectionViewStartingBell.configureForPeekingBehavior(behavior: behavior)
        
        }
    
    
    func convertingSecondsToCountDown(time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time) / 60 % 60
        let s = Int(time) % 60
        return String(format: "%02i:%02i:%02i", h,m,s )
    }

    @IBAction func startButton(_ sender: Any) {
    print("Moving to TDC")

    }
    
    @IBAction func repeatBellButtonStarting(_ sender: UIButton) {
        let circle = UIImage(systemName: "circle")
        
        updateBellButton()
        sender.isSelected = true
        sender.alpha = 1.0
        sender.setBackgroundImage(circle, for: UIControl.State.normal)
//        
//        switch sender.currentTitle {
//        case "1":
//            playerStartingBell.numberOfLoops = 1
//        case "2":
//            playerStartingBell.numberOfLoops = 2
//        case "3":
//            playerStartingBell.numberOfLoops = 3
//        default:
//            //player.numberOfLoops = 1
//            print("Player.NumberOfLoops Failed ")
//            
//        }
    }
    func updateBellButton() {
       
        repeatBellButtonOneStarting.isSelected = false
        repeatBellButtonOneStarting.alpha = 0.3
        repeatBellButtonOneStarting.setBackgroundImage(nil, for: UIControl.State.normal)
       
        repeatBellButtonTwoStarting.isSelected = false
        repeatBellButtonTwoStarting.alpha = 0.3
        repeatBellButtonTwoStarting.setBackgroundImage(nil, for: UIControl.State.normal)
      
        repeatBellButtonThreeStarting.isSelected = false
        repeatBellButtonThreeStarting.alpha = 0.3
        repeatBellButtonThreeStarting.setBackgroundImage(nil, for: UIControl.State.normal)
        
    }
    


    
//MARK: - Duration/Modal
    @IBAction func durationButton(_ sender: UIButton) {
       let durationVC = storyboard?.instantiateViewController(withIdentifier: "DurationController") as! DurationController//

        durationVC.timeManagerDelegate = self
        durationVC.modalPresentationStyle = .fullScreen
        self.present(durationVC, animated: true, completion: nil)
       
        
    }
    //MARK: - EndingBell Also Modal Presentation
    @IBAction func endingBellButton(_ sender: UIButton) {
        let endingVC = storyboard?.instantiateViewController(withIdentifier: "EndingBellController") as! EndingBellController
        endingVC.endingBellSoundDelegate = self
        endingVC.modalPresentationStyle = .fullScreen
        
        present(endingVC, animated: true, completion: nil)
        
    }
    
//MARK: - StartScreenController Modal Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "beginSegue" {
            let destinationTDC = segue.destination as! StartScreenController

           
            destinationTDC.chosenSoundForEndingOfBell = soundChosenFromEndingBellController
            destinationTDC.hours = hours
            destinationTDC.minutes = minutes
            destinationTDC.seconds = seconds
        }
    }
}
//MARK: - DurationController Protocol Extension
extension MainScreenController: TimeManagerDelegate {
   //This is code for later
    func didUpdateTimer(hoursDelegate: Int, minutesDelegate: Int, secondsDelegate: Int) {
         hours = hoursDelegate
         minutes = minutesDelegate
         seconds = secondsDelegate
        let finalSeconds = (hours * hrs) + (minutes * min) + (seconds + 3600) % sec
        durationTimer.text = convertingSecondsToCountDown(time: TimeInterval(finalSeconds))
    }

}
//MARK: - EndingBellController Protocol Extension
extension MainScreenController: EndingBellSoundSelection {
    func didSelectEndingBell(soundNamePlayer: String, soundNameLabel: String) {
        endingBellAssistingLabel.text = soundNameLabel
        soundChosenFromEndingBellController = soundNamePlayer
    }
    
    
}
extension MainScreenController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    //Assigns Images and Lable names to the bells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCellStartingBell
        
        let images = imageArray[indexPath.row]
        cell.imageBellStarting.image = images
        
        let imageNames = imageArrayBellNames[indexPath.row]
        cell.startingBellLabel.text = imageNames
        
        return cell
    }
    //MARK: - Scroll View Picker
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let currentIndex = self.collectionViewStartingBell.contentOffset.x / self.collectionViewStartingBell.frame.size.width
        let indexPathNoDecimal = String(format: "%.0f", currentIndex * 1.1)
        
      //  chosenSound = indexPathNoDecimal
        playSound(soundName: indexPathNoDecimal)
        print(indexPathNoDecimal)
        
//Picks the Sound for the delegate to move it to MainScreenController
        switch indexPathNoDecimal {
        case "0":
            chosenSoundForStartingBell = "0"
        case "1":
            chosenSoundForStartingBell = "1"
        case "2":
            chosenSoundForStartingBell = "2"
        case "3":
            chosenSoundForStartingBell = "3"
        case "4":
            chosenSoundForStartingBell = "4"
        case "5":
            chosenSoundForStartingBell = "5"
        case "6":
            chosenSoundForStartingBell = "6"
        case "7":
            chosenSoundForStartingBell = "7"
        case "8":
            chosenSoundForStartingBell = "8"
        default:
            playSound(soundName: "0")
        }
//
//        if chosenSound != nil {
//            player.numberOfLoops = 1
//        } else if repeatBellButtonTwo != nil {
//            player.numberOfLoops = 2
//        } else if repeatBellButtonThree != nil {
//            player.numberOfLoops = 3
//        }
    
    
    } //MARK: - DidSelect Item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        chosenSoundForStartingBell = String(indexPath.row)
         playSoundStartingBell(soundName: chosenSoundForStartingBell)
         print(chosenSoundForStartingBell)
        
        switch chosenSoundForStartingBell {
               case "0":
                   chosenSoundForStartingBell = "0"
               case "1":
                   chosenSoundForStartingBell = "1"
               case "2":
                   chosenSoundForStartingBell = "2"
               case "3":
                   chosenSoundForStartingBell = "3"
               case "4":
                   chosenSoundForStartingBell = "4"
               case "5":
                   chosenSoundForStartingBell = "5"
               case "6":
                   chosenSoundForStartingBell = "6"
               case "7":
                   chosenSoundForStartingBell = "7"
               case "8":
                   chosenSoundForStartingBell = "8"
               default:
                   playSound(soundName: "0")
               }
       }
    
}

extension MainScreenController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
       
    }
}
//Music is created here
var playerStartingBell: AVAudioPlayer!

func playSoundStartingBell(soundName: String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
}
