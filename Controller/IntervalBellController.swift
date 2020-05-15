//
//  IntervalBellController.swift
//  InsightMind
//
//  Created by Bartek on 5/9/20.
//  Copyright © 2020 Bartek. All rights reserved.


import Foundation
import UIKit

class IntervalBellController: UIViewController {
    
    //When user clicks save it will save a bell and then reload the data 
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
    var dataPresented: TimeData?
    
    var thisImage = ""
    var soundLength = ""
    var firstName = ""
    var lastName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButtonEditable.tintColor = UIColor.white.withAlphaComponent(0.5)
        editButtonEditable.tintColor = UIColor.white.withAlphaComponent(0.5)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.reloadData()
        images = createArray()
        
        
    }
    func createArray() -> [TimeData] {
        
        var tempImages: [TimeData] = []
        
       // tempImages.append(dataPresented!)
        
        let image1 = TimeData(bellImage: UIImage(named: "0")!, totalTime: "00:00:00", bellName: "Basu-Bell 1", supportingBellName: "Basu 3 Strikes")

//           tempImages.append(TimeData(bellImage: UIImage(named: imageName) ?? UIImage(named: "0")!, totalTime: secondsConverted, bellName: "Poop", supportingBellName: "Nope"))
    
        tempImages.append(dataPresented ?? image1)
        tempImages.append(image1)
        tableView.reloadData()
        return tempImages
        
    }

    @IBAction func saveNavButton(_ sender: UIBarButtonItem) {
    }
    @IBAction func cancelNavButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
}
    @IBAction func addBellButton(_ sender: UIButton) {
        let addBellVC = storyboard?.instantiateViewController(withIdentifier: "IntervalPickerController") as! IntervalPickerController
        
        tableView.reloadData()
        
        addBellVC.intervalDataManagerDelegate = self
        addBellVC.modalPresentationStyle = .fullScreen
        present(addBellVC, animated: true, completion: nil)
    }
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        
        
    }
    func convertingSecondsToCountDown(time: TimeInterval) -> String {
        let h = Int(time) / 3600
        let m = Int(time) / 60 % 60
        let s = Int(time) % 60
        return String(format: "%02i:%02i:%02i", h,m,s )
    }
    
    
}
extension IntervalBellController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    //Indexpath.row is whatever object is at that row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let image = images[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BellCell") as! TableViewCell
        
        
        cell.tableViewImage.image = UIImage(named: thisImage)
        cell.intervalPickedTime.text = soundLength
        cell.chosenBellName.text = firstName
        cell.supportingBellName.text = lastName
       // cell.setCell(timeData: image)
        return cell
        
    }
    
    

    
    
}


extension IntervalBellController: moveDataToIntervalPickerProtocol {
    func didMoveIntervalDataPractise(bellImage: String, totalTime: String, bellName: String, supportingBellName: String) {
        thisImage = bellImage
        soundLength = totalTime
        firstName = bellName
        lastName = supportingBellName
    }
    
    func didMoveIntervalData(bellInfo: TimeData) {
        
        
        dataPresented = bellInfo
    }
    
    
    
//    func didMoveIntervalData(bellImage: String, totalTime: String, bellName: String, supportingBellName: String) {
//        var tempImages: [TimeData] = []
        
//        tempImages.append(TimeData(bellImage: bellImage, totalTime: totalTime, bellName: bellName, supportingBellName: supportingBellName))
//
        
 //   }
    



}
