//
//  AmbientViewController.swift
//  InsightMind
//
//  Created by Bartek on 5/9/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
//
//@IBOutlet weak var ambientImage: UIImageView!
//   @IBOutlet weak var ambientLabel: UILabel!
protocol AmbientSoundProtocol {
    func didGetSound(soundName: String, soundChoice: String)
}

class AmbientViewController: UIViewController {
    
    var ambientSoundDelegate: AmbientSoundProtocol!
    
    @IBOutlet weak var ambientLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var chosenAmbientImage = ""
    var ambientDelegateLabel = ""
    
    
    var imageArray: [UIImage] = [
        UIImage(named: "scaryNight")!,
        UIImage(named: "warm_Afternoon")!,
        UIImage(named: "bird_isTheWord")!,
        UIImage(named: "riverApacheHelicopter")!,
        UIImage(named: "beach")!,
        UIImage(named: "womanWithGuitar")!,
        UIImage(named: "thunder")!,
        UIImage(named: "forestDay")!,
        UIImage(named: "gongthing")!,
        UIImage(named: "zenGarden")!,
        UIImage(named: "zenTree")!,
        UIImage(named: "plant")!,
        UIImage(named: "buddhaWithLight")!,
        UIImage(named: "fire")!,
        UIImage(named: "buddhaFace")!,
        UIImage(named: "guitarPicture")!,
        UIImage(named: "buddhaBreathing")!,
        UIImage(named: "manOnBridge")!,
        UIImage(named: "boat")!,
        UIImage(named: "bridge")!
        
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CollectionViewCellAmbientSound.nib(), forCellWithReuseIdentifier: CollectionViewCellAmbientSound.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 120)
        collectionView.collectionViewLayout = layout
        
        
    }
    
    @IBAction func cancelNavButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        player.stop()
    }
    @IBAction func saveNavButton(_ sender: UIBarButtonItem) {

        if ambientDelegateLabel != "" {
        ambientSoundDelegate?.didGetSound(soundName: ambientDelegateLabel, soundChoice: chosenAmbientImage)
        } else {
            print("Error")
        }
        self.dismiss(animated: true, completion: nil)
        player.stop()
    }
    
}

extension AmbientViewController: UICollectionViewDelegate {//Delegate helps to pick up interaction with the cells
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        chosenAmbientImage = String(indexPath.item)
        //SomeSoundsHaveBeenChangedToFitThePicture 
        switch chosenAmbientImage {
        case "0":
            chosenAmbientImage = "scaryNight"
            ambientDelegateLabel = "No Sound"
            ambientLabel.text = ambientDelegateLabel
            playSound(soundName: chosenAmbientImage)//I will have to loop the sounds in a seperate screen
        case "1":
            ambientDelegateLabel = "Warm Afternoon"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "warm_Afternoon"
            playAmbientSound(soundName: chosenAmbientImage)
        case "2":
            ambientDelegateLabel = "Bird song"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "bird_isTheWord"
            playAmbientSound(soundName: chosenAmbientImage)
        case "3":
            ambientDelegateLabel = "Stream of sound"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "riverApacheHelicopter"
            playAmbientSound(soundName: chosenAmbientImage)
        case "4":
            ambientDelegateLabel = "Beach waves"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "zenTree"
            playAmbientSound(soundName: chosenAmbientImage)
        case "5":
            ambientDelegateLabel = "Raining day"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "womanWithGuitar"
            playAmbientSound(soundName: chosenAmbientImage)
        case "6":
            ambientDelegateLabel = "Thunder"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "thunder"
            playAmbientSound(soundName: chosenAmbientImage)
        case "7":
            ambientDelegateLabel = "Morning stretch"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "beach"
            playAmbientSound(soundName: chosenAmbientImage)
        case "8":
            ambientDelegateLabel = "Crow Echo"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "gongthing"
            playAmbientSound(soundName: chosenAmbientImage)
        case "9":
            ambientDelegateLabel = "Zen Garden"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "zenGarden"
            playAmbientSound(soundName: chosenAmbientImage)
        case "10":
            ambientDelegateLabel = "Soothing colors"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "forestDay"
            playAmbientSound(soundName: chosenAmbientImage)
        case "11":
            ambientDelegateLabel = "Reflections"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "buddhaFace"
            playAmbientSound(soundName: chosenAmbientImage)
        case "12":
            ambientDelegateLabel = "Nighttime insights"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "plant"
            playAmbientSound(soundName: chosenAmbientImage)
        case "13":
            ambientDelegateLabel = "Winter fire"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "fire"
            playAmbientSound(soundName: chosenAmbientImage)
        case "14":
            ambientDelegateLabel = "Outdoor meditations"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "buddhaWithLight"
            playAmbientSound(soundName: chosenAmbientImage)
        case "15":
            ambientDelegateLabel = "Stillness"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "guitarPicture"
            playAmbientSound(soundName: chosenAmbientImage)
        case "16":
            ambientDelegateLabel = "Infinite breath"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "buddhaBreathing"
            playAmbientSound(soundName: chosenAmbientImage)
        case "17":
            ambientDelegateLabel = "Nature's melody"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "manOnBridge"
            playAmbientSound(soundName: chosenAmbientImage)
        case "18":
            ambientDelegateLabel = "In motion"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "boat"
            playAmbientSound(soundName: chosenAmbientImage)
        case "19":
            ambientDelegateLabel = "Relax into inquiry"
            ambientLabel.text = ambientDelegateLabel
            chosenAmbientImage = "bridge"
            playAmbientSound(soundName: chosenAmbientImage)
        default:
            ambientLabel.text = "No Sound"
            chosenAmbientImage = "0"
        }

        
    }
    
    
}

extension AmbientViewController: UICollectionViewDataSource {//tells howmany cells in a given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        imageArray.count
        return imageArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellAmbientSound.identifier, for: indexPath) as!  CollectionViewCellAmbientSound
        //This is the image that will show up in the cell
        //cell.imageView.image = imageArray[indexPath.count]
        //cell.configure(with: UIImage(named: String(imageNames.count))!)
        cell.imageView.image = imageArray[indexPath.item]
//        cell.configure(with: UIImage(named: "1")!)
//        cell.ambientImage.image = imageArray[indexPath.item]
        return cell
    }
}

extension AmbientViewController: UICollectionViewDelegateFlowLayout {
    //margin and padding between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
    
}
var AmbientPlayer: AVAudioPlayer!

func playAmbientSound(soundName: String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
}

