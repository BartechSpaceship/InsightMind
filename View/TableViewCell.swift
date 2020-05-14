//
//  TableViewCell.swift
//  InsightMind
//
//  Created by Bartek on 5/14/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewImage: UIImageView!
    @IBOutlet weak var chosenBellName: UILabel!
    @IBOutlet weak var supportingBellName: UILabel!
    @IBOutlet weak var intervalPickedTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(timeData: TimeData ){
        tableViewImage.image = timeData.bellImage
        chosenBellName.text = timeData.bellName
        supportingBellName.text = timeData.supportingBellName
        intervalPickedTime.text = timeData.totalTime
    }

}
