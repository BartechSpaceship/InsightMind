//
//  IntervalBellController.swift
//  InsightMind
//
//  Created by Bartek on 5/9/20.
//  Copyright © 2020 Bartek. All rights reserved.


import Foundation
import UIKit

class IntervalBellController: UIViewController {
    
    
    @IBOutlet weak var settingsButtonEditable: UIBarButtonItem!
    
    @IBOutlet weak var editButtonEditable: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButtonEditable.tintColor = UIColor.white.withAlphaComponent(0.5)
        editButtonEditable.tintColor = UIColor.white.withAlphaComponent(0.5)
//        tableView.delegate = self
//        tableView.dataSource = self
        
    }
    
    @IBAction func saveNavButton(_ sender: UIBarButtonItem) {
    }
    @IBAction func cancelNavButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
}
    @IBAction func addBellButton(_ sender: UIButton) {
        let addBellVC = storyboard?.instantiateViewController(withIdentifier: "IntervalPickerController") as! IntervalPickerController
        
        addBellVC.modalPresentationStyle = .fullScreen
        present(addBellVC, animated: true, completion: nil)
    }
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    
}
