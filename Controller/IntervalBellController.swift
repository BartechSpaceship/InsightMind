//
//  IntervalBellController.swift
//  InsightMind
//
//  Created by Bartek on 5/9/20.
//  Copyright © 2020 Bartek. All rights reserved.


import Foundation
import UIKit

class IntervalBellController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingsButtonEditable: UIBarButtonItem!
    @IBOutlet weak var editButtonEditable: UIBarButtonItem!
    
    var finalSeconds = 0
    
    let hrs = 3600
    let min = 3600 / 60
    let sec = 60
    
    var imageName = ""
    var secondsConverted = "0"
    var images: [TimeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButtonEditable.tintColor = UIColor.white.withAlphaComponent(0.5)
        editButtonEditable.tintColor = UIColor.white.withAlphaComponent(0.5)
        tableView.delegate = self
        tableView.dataSource = self

//        images = createArray()
    }
//    func createArray() -> [TimeData] {
//           var tempImages: [TimeData] = []
//           
//        let image1 = TimeData(bellImage: UIImage(named: imageName) ?? UIImage(named: "4")!, totalTime: secondsConverted, bellName: "Basu-Bell 1", supportingBellName: "Basu 3 Strikes")
//
//           tempImages.append(image1)
//
//        return tempImages
//    }

    @IBAction func saveNavButton(_ sender: UIBarButtonItem) {
    }
    @IBAction func cancelNavButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
}
    @IBAction func addBellButton(_ sender: UIButton) {
        let addBellVC = storyboard?.instantiateViewController(withIdentifier: "IntervalPickerController") as! IntervalPickerController
        
        
        
        addBellVC.intervalDataManagerDelegate = self
        addBellVC.modalPresentationStyle = .fullScreen
        present(addBellVC, animated: true, completion: nil)
    }
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    
}
extension IntervalBellController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    //Indexpath.row is whatever object is at that row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let image = images[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BellCell") as! TableViewCell
        
        cell.setCell(timeData: image)
        return cell
        
    }
    
    
}
func convertingSecondsToCountDown(time: TimeInterval) -> String {
    let h = Int(time) / 3600
    let m = Int(time) / 60 % 60
    let s = Int(time) % 60
    return String(format: "%02i:%02i:%02i", h,m,s )
}

extension IntervalBellController: moveDataToIntervalPickerProtocol {
    func bellsCreated(bell: TimeData) {
        TimeData(bellImage: bell, totalTime: bell, bellName: bell, supportingBellName: bell
    }
    


}
