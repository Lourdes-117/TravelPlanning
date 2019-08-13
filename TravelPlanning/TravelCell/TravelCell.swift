//
//  TravelCell.swift
//  TravelPlanning
//
//  Created by Tringapps on 08/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

class TravelCell: UITableViewCell {
    @IBOutlet weak var travelModeImage: UIImageView!
    @IBOutlet weak var fromLocation: UILabel!
    @IBOutlet weak var toLocation: UILabel!
    @IBOutlet weak var dateOfTravel: UILabel!
    @IBOutlet weak var descriptionOfTravel: UILabel!

    func setValues(travelDetail:TravelModel){
        self.fromLocation.text = travelDetail.from
        self.toLocation.text = travelDetail.to
        self.dateOfTravel.text = travelDetail.date
        self.descriptionOfTravel.text = travelDetail.reason
        self.travelModeImage.image = GetTravelModeImage.getImage(ofString: travelDetail.modeOfTransport)
    }
}
