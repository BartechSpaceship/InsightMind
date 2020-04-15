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


class TimeController: UIViewController{
    
    @IBOutlet weak var timePicker: UIPickerView!

    //Used for the UIPickerView
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.delegate = self
        timePicker.dataSource = self
        
        
        
    }
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "saveSegue" {
            let destinationSC = segue.destination as! SelectionController
            destinationSC.hours = hours
            destinationSC.minutes = minutes
            destinationSC.seconds = seconds
            
            
            
        }
    }
    //MARK: - Navigation Bar Buttons
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        
        print("cancel")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "saveSegue", sender: self)
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
}




    
    
    


 
