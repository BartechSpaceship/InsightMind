//
//  IntervalPickerController.swift
//  InsightMind
//
//  Created by Bartek on 5/11/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit
import MSPeekCollectionViewDelegateImplementation
//I am going to have to do all the data conversion here and then when clicked save the tableViewCell will be created

protocol moveDataToIntervalPickerProtocol {//Will add bell repetitions in the future and bell name
    func didMoveIntervalDataPractise(bellImage: String, totalTime: String, bellName: String, supportingBellName: String)
    func didMoveIntervalData(bellInfo: TimeData)
    
}
//The Cell will be created inside of this controller but will populate the data using a delegate inside of the Bell Controller
class IntervalPickerController: UIViewController {
    
    var intervalDataManagerDelegate: moveDataToIntervalPickerProtocol?
    
    @IBOutlet weak var repeatBellButtonOne: UIButton!
    @IBOutlet weak var repeatBellButtonTwo: UIButton!
    @IBOutlet weak var repeatBellButtonThree: UIButton!
    @IBOutlet weak var pickerController: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60
    
    var finalSeconds = 0
    var chosenSound = ""
    var chosenSoundLabel = ""
    var images: [TimeData] = []
    
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
        
        pickerController.delegate = self
        pickerController.dataSource = self
        
            collectionView.delegate = self
            collectionView.dataSource = self
        //If this is changed then you have to change the center point of the app "Current Index"
            behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 50)
            behavior = MSCollectionViewPeekingBehavior(cellSpacing: 70)
          
            collectionView.configureForPeekingBehavior(behavior: behavior)
     
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {//How to get image into IntervalBellController? HMMM
        
        
            finalSeconds = (hours * hrs) + (minutes * min) + (seconds + 3600) % sec
            //I will create the imageitself here but it needs to populate in the other view controller
//            images = createArray()
//            intervalDataManagerDelegate?.didMoveIntervalData(bellImage: "", totalTime: convertingSecondsToCountDown(time: TimeInterval(finalSeconds)), bellName: "Penelope", supportingBellName: "Cruz")
        intervalDataManagerDelegate?.didMoveIntervalDataPractise(bellImage: chosenSound, totalTime: convertingSecondsToCountDown(time: TimeInterval(finalSeconds)), bellName: "Spaceman", supportingBellName: "Yup")
            let bell = TimeData(bellImage: UIImage(named: chosenSound)!, totalTime: convertingSecondsToCountDown(time: TimeInterval(finalSeconds)), bellName: "Ostrich", supportingBellName: "Pen")
            intervalDataManagerDelegate?.didMoveIntervalData(bellInfo: bell)
            
            
//            let image1 = TimeData(bellImage: UIImage(named: chosenSound) ?? UIImage(named: "4")!, totalTime: convertingSecondsToCountDown(time: TimeInterval(finalSeconds)), bellName: "Basu-Bell 1", supportingBellName: "Basu 3 Strikes")
            
        
        

        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func changeBellName(_ sender: UIButton) {
        
    }
    func convertingSecondsToCountDown(time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time) / 60 % 60
        let s = Int(time) % 60
        return String(format: "%02i:%02i:%02i", h,m,s )
    }
    
    
    
    
    
    
    //MARK: - 1,2,3 Buttons
    @IBAction func repeatBellButton(_ sender: UIButton) {
        let circle = UIImage(systemName: "circle")
               
               updateBellButton()
               sender.isSelected = true
               sender.alpha = 1.0
               sender.setBackgroundImage(circle, for: UIControl.State.normal)

                   switch sender.currentTitle {
               case "1":
                   player.numberOfLoops = 1
               case "2":
                   player.numberOfLoops = 2
               case "3":
                   player.numberOfLoops = 3
               default:
                   //player.numberOfLoops = 1
                   print("Player.NumberOfLoops Failed ")

               }
               
}
           func updateBellButton() {
              
               repeatBellButtonOne.isSelected = false
               repeatBellButtonOne.alpha = 0.3
               repeatBellButtonOne.setBackgroundImage(nil, for: UIControl.State.normal)
              
               repeatBellButtonTwo.isSelected = false
               repeatBellButtonTwo.alpha = 0.3
               repeatBellButtonTwo.setBackgroundImage(nil, for: UIControl.State.normal)
             
               repeatBellButtonThree.isSelected = false
               repeatBellButtonThree.alpha = 0.3
               repeatBellButtonThree.setBackgroundImage(nil, for: UIControl.State.normal)
               
           }
           
    }


//MARK: - Collection View Data Source/Delegates
extension IntervalPickerController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    //Assigns Images and Lable names to the bells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let images = imageArray[indexPath.row]
        cell.imageBell.image = images
        
        let imageNames = imageArrayBellNames[indexPath.row]
        cell.bellNameDisplay.text = imageNames
        
        return cell
    }
    //MARK: - Select Sound Here/
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let currentIndex = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
        let indexPathNoDecimal = String(format: "%.0f", currentIndex * 1.4)
        
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
//
//        if chosenSound != nil {
//            player.numberOfLoops = 1
//        } else if repeatBellButtonTwo != nil {
//            player.numberOfLoops = 2
//        } else if repeatBellButtonThree != nil {
//            player.numberOfLoops = 3
//        }
//
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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

extension IntervalPickerController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
       
    }

//}
//extension EndingBellController: UICollectionViewDelegateFlowLayout {
////margin and padding between each cell
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width: 130, height: 130)
//}

}
//MARK: - Picker Delegate and Datasource
extension IntervalPickerController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    //Rows & Numbers
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60
        default:
            return 0
        }
    }

   

    //Width
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/5
    }
    //Title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) h"
        case 1:
            return "\(row) m"
        case 2:
            return "\(row) s"
        default:
            return ""
        }
    }
    //Selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
            
            
        }
        
    }
    //MARK: - Changes PickerView Color
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let string = "\(row) "

        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       }
}

