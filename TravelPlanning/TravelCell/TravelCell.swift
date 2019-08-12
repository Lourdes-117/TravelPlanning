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
        switch travelDetail.modeOfTransport {
        case ModeOfTransports.FLIGHT.rawValue:
            self.travelModeImage.image = #imageLiteral(resourceName: "flight-Icon")
        case ModeOfTransports.MOTORBIKE.rawValue:
            self.travelModeImage.image = #imageLiteral(resourceName: "bike-Icon")
        case ModeOfTransports.CAR.rawValue:
            self.travelModeImage.image = #imageLiteral(resourceName: "car-Icon")
        case ModeOfTransports.BUS.rawValue:
            self.travelModeImage.image = #imageLiteral(resourceName: "bus-Icon")
        case ModeOfTransports.TRAIN.rawValue:
            self.travelModeImage.image = #imageLiteral(resourceName: "train-icon")
        default:
            print(Errors.INVALID_MODE_OF_TRANSPORT)
        }
    }
}
