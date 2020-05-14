//
//  TimeData.swift
//  InsightMind
//
//  Created by Bartek on 4/9/20.
//  Copyright © 2020 Bartek. All rights reserved.
//
//
import Foundation
import UIKit

class TimeData {
    var bellImage: UIImage
    var totalTime: String
    var bellName: String
    var supportingBellName: String
    
    init(bellImage: UIImage, totalTime: String, bellName: String, supportingBellName: String) {
        self.bellImage = bellImage
        self.totalTime = totalTime
        self.bellName = bellName
        self.supportingBellName = supportingBellName
    }
    
}
