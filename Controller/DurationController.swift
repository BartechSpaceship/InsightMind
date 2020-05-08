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
    func didUpdateTimer(hoursDelegate: Int, minutesDelegate: Int, secondsDelegate: Int)
}

class DurationController: UIViewController{
    
    @IBOutlet weak var timePicker: UIPickerView!

    var timeManagerDelegate: TimeManagerDelegate?
    
    //Used for the UIPickerView
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.delegate = self
        timePicker.dataSource = self
        
        
    }
    //MARK: - Navigation Bar Buttons

    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        if(hours != 0 || minutes != 0 || seconds != 0){
        timeManagerDelegate?.didUpdateTimer(hoursDelegate: hours, minutesDelegate: minutes, secondsDelegate: seconds)
        } else {
            print("fail")
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
   
    
}
func convertingSecondsToCountDown(time: TimeInterval) -> String {
    let h = Int(time) / 3600
    let m = Int(time) / 60 % 60
    let s = Int(time) % 60
    return String(format: "%02i:%02i:%02i", h,m,s )
}

    


//MARK: - PickerViewDelegate & DataSource
extension DurationController: UIPickerViewDelegate, UIPickerViewDataSource {
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




    
    
    


 
