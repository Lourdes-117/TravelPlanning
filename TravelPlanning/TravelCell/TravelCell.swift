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
    @IBOutlet weak var backgroundCardView: UIView!

    func setValues(travelDetail:TravelModel){
        self.fromLocation.text = travelDetail.from
        self.toLocation.text = travelDetail.to
        self.dateOfTravel.text = travelDetail.date
        self.descriptionOfTravel.text = travelDetail.reason
        self.travelModeImage.image = GetTravelModeImage.getImage(ofString: travelDetail.modeOfTransport)
        setCardViewDesign()
    }

    func setCardViewDesign() {
        contentView.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.2)
        let cornerRadius:CGFloat = 3.0
        backgroundCardView.layer.cornerRadius = cornerRadius
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.6
    }
}
