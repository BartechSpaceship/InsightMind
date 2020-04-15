//
//  ViewController.swift
//  InsightMind
//
//  Created by Bartek on 4/9/20.
//  Copyright © 2020 Bartek. All rights reserved.
//


import UIKit
import Foundation
import AVFoundation

protocol TimeManagerDelegate {
    func calculateTotalSeconds(hr: Int, min: Int, sec: Int )
}
    
class TimeController: UIViewController, TimeManagerDelegate {
    
    
    

    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!

    
    
    //Used for the UIPickerView
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0

    var totalSeconds = 0
    var timer = Timer()

    let hrs = 3600
    let min = 3600 / 60
    let sec = 60

    var delegate: TimeManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timePicker.delegate = self
        timePicker.dataSource = self
       
        
    }//MARK: - DELEGATE MTHD
    func calculateTotalSeconds(hr: Int, min: Int, sec: Int) {
        delegate?.calculateTotalSeconds(hr: hours, min: minutes, sec: seconds)
    }
    //MARK: - Start Button
    @IBAction func startTimer(_ sender: UIButton) {
        timer.invalidate()
       

        //Moving TO SAVE BUTTON
        totalSeconds = (hours * hrs) + (minutes * min) + (seconds + 3600) % sec
        
       
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)



       

    }
    //MARK: - Navigation Bar Buttons
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {

        print("cancel")
        self.dismiss(animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "saveSegue" {
            let destinationSC = segue.destination as! SelectionController
            destinationSC.totalSec = totalSeconds
            destinationSC.hours = hours
            destinationSC.minutes = minutes
            destinationSC.seconds = seconds
            
            
            
        }
    }
//    func totalSecondsCombined() -> Int {
//        totalSeconds = (hours * hrs) + (minutes * min) + (seconds + 3600) % sec
//        return totalSeconds
//    }
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        
        
        print(totalSeconds)
        self.performSegue(withIdentifier: "saveSegue", sender: self)
        totalSeconds = (hours * hrs) + (minutes * min) + (seconds + 3600) % sec
                    
                
        }
        
        
    }




//MARK: - PickerViewDelegate & DataSource
extension TimeController: UIPickerViewDelegate, UIPickerViewDataSource {
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
    
   // MARK: - Update UI
    @objc func updateUI(){

        if totalSeconds != -1 {
            //This can be its own 2 methods 
           // timeLabel.text = convertingSecondsToCountDown(time: TimeInterval(totalSeconds))
            totalSeconds -= 1
            print(totalSeconds)
        } else {
            playSound()
            timer.invalidate()
            print("Done")
        }

    }
    func convertingSecondsToCountDown(time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time) / 60 % 60
        let s = Int(time) % 60
        return String(format: "%02i:%02i:%02i", h,m,s)
    }
}

//MARK: - Music
var player: AVAudioPlayer?

func playSound() {
    guard let url = Bundle.main.url(forResource: "C", withExtension: "wav") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)



    }
}


    
    
    


 
