//
//  TimeDisplayController.swift
//  InsightMind
//
//  Created by Bartek on 4/9/20.
//  Copyright © 2020 Bartek. All rights reserved.
//Note to self later , try seeing if you can push data back modally and use protocol to get the time instead of doing what yo udid last tine w

import UIKit
import Foundation
import AVFoundation



class StartScreenController: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    var finalSeconds = 0
    var timer = Timer()
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var audioPlayer = AVAudioPlayer()
    var chosenSoundForEndingOfBell = ""
   
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        finalSeconds = (hours * hrs) + (minutes * min) + (seconds + 3600) % sec
               
               timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)

    }
   
    
    
    @IBAction func finishButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        timer.invalidate()
    }
    func convertingSecondsToCountDown(time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time) / 60 % 60
        let s = Int(time) % 60
        return String(format: "%02i:%02i:%02i", h,m,s )
    }
    
    
    @objc func updateUI(){
        
        if finalSeconds != -1 {
            timeLabel.text = convertingSecondsToCountDown(time: TimeInterval(finalSeconds))
            finalSeconds -= 1
            print(finalSeconds)
        } else {
            playSound(soundName: chosenSoundForEndingOfBell)
            timer.invalidate()
            print("Done")
        }
        
    }
    

var player: AVAudioPlayer!

func playSound(soundName: String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
     player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
}

}
