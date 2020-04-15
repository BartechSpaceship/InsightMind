//
//  SelectionController.swift
//  InsightMind
//
//  Created by Bartek on 4/11/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit

class SelectionController: UIViewController {
    
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
   
    var timer = Timer()
    var totalSec: Int = 0
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60
    
    
    
    @IBOutlet weak var timeLabelTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func startButton(_ sender: Any) {
        
         self.performSegue(withIdentifier: "beginSegue", sender: self)
    
        
        
    }
    
    
    @IBAction func durationButton(_ sender: UIButton) {
        print("Select Duration")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "beginSegue" {
            let destinationTDC = segue.destination as! TimeDisplayController
            destinationTDC.finalSeconds = totalSec
            destinationTDC.hours = hours
            destinationTDC.minutes = minutes
            destinationTDC.seconds = seconds
            
            
            
        }
    }
     @objc func updateUI(){

            if totalSec != -1 {
                timeLabelTest.text = convertingSecondsToCountDown(time: TimeInterval(totalSec))
                totalSec -= 1
                print(totalSec)
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


