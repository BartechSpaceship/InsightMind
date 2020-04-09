//
//  ViewController.swift
//  InsightMind
//
//  Created by Bartek on 4/9/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var totalSeconds = 0
    var timer = Timer()
//    var h = 0
//    var m = 0
//    var s = 0
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.delegate = self
        timePicker.dataSource = self
        updateUI()
        // Do any additional setup after loading the view.
    }
    //MARK: - Start Button
    @IBAction func startTimer(_ sender: UIButton) {
        timer.invalidate()
        totalSeconds = (hours * hrs) + (minutes * min) + (seconds + 3600) % sec
        
        
        //print(timeString(time: TimeInterval(totalSeconds)))
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        
        
    }
    
}
//MARK: - PickerViewDelegate & DataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        return pickerView.frame.size.width/4
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
    //MARK: - DataModel
    //take the hours and divide them and THEN do the count down method without the total sec method
    func changingSecondsToString (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func updateUI(){
    
        
        if totalSeconds != -1 {
            timeLabel.text = convertingSecondsToCountDown(time: TimeInterval(totalSeconds))
             totalSeconds -= 1
            print(totalSeconds)
        } else {
            timer.invalidate()
            print("Error")
        }
        
    }
    func convertingSecondsToCountDown(time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time) / 60 % 60
        let s = Int(time) % 60
        return String(format: "%02i:%02i:%02i", h,m,s)
    }
    
}

