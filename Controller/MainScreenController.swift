//
//  SelectionController.swift
//  InsightMind
//
//  Created by Bartek on 4/11/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit

class MainScreenController: UIViewController {
    
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    
    
    
    @IBOutlet weak var durationTimer: UILabel!
    @IBOutlet weak var endingBellAssistingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


    
//MARK: - Duration
    @IBAction func durationButton(_ sender: UIButton) {
       let durationVC = storyboard?.instantiateViewController(withIdentifier: "DurationController") as! DurationController//

        durationVC.timeManagerDelegate = self
        durationVC.modalPresentationStyle = .fullScreen
        self.present(durationVC, animated: true, completion: nil)
        print("Select Duration")
    }
    
    @IBAction func endingBellButton(_ sender: UIButton) {
        let endingVC = storyboard?.instantiateViewController(withIdentifier: "EndingBellController") as! EndingBellController
        endingVC.endingBellSoundDelegate = self
        endingVC.modalPresentationStyle = .fullScreen
        
        present(endingVC, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
//MARK: - Start
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "beginSegue" {
            let destinationTDC = segue.destination as! StartScreenController

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

extension MainScreenController: EndingBellSoundSelection {
    func didSelectEndingBell(soundNamePlayer: String) {
        endingBellAssistingLabel.text = soundNamePlayer
    }
    
    
}
