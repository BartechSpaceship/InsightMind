//
//  SelectionController.swift
//  InsightMind
//
//  Created by Bartek on 4/11/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit

class SelectionController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var bellImages: UIStackView!
    
    @IBOutlet weak var horizontalStack: UIStackView!
    
    
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    @IBAction func startButton(_ sender: Any) {
    print("Moving to TDC")
        
    }
    
    
    @IBAction func durationButton(_ sender: UIButton) {
        print("Select Duration")
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "beginSegue" {
            let destinationTDC = segue.destination as! TimeDisplayController
            destinationTDC.hours = hours
            destinationTDC.minutes = minutes
            destinationTDC.seconds = seconds
        }
    }
 
    
}

