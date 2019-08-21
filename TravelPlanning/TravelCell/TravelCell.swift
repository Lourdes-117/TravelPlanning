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
    @IBOutlet weak var travelTimeIndicator: UIView!
    @IBOutlet var allTextsInView: [UILabel]!

    func setValues(travelDetail:TravelModel, travelTime:TravelTime){
        self.fromLocation.text = travelDetail.from
        self.toLocation.text = travelDetail.to
        self.dateOfTravel.text = travelDetail.date
        self.descriptionOfTravel.text = travelDetail.reason
        self.travelModeImage.image = GetTravelModeInfo.getImage(ofString: travelDetail.modeOfTransport)
        setCardViewDesign()
        switch travelTime {
        case .Past:
            travelTimeIndicator.backgroundColor = Colors.DARK_RED
        case .Today:
            travelTimeIndicator.backgroundColor = Colors.GREEN
        case .Future:
            travelTimeIndicator.backgroundColor = Colors.YELLOW
        }
    }

    func setCardViewDesign() {
        contentView.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.2)
        let cornerRadius:CGFloat = 3.0
        backgroundCardView.layer.cornerRadius = cornerRadius
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 2, height: 4)
        backgroundCardView.layer.shadowOpacity = 0.8

        backgroundCardView.layer.backgroundColor = CurrentTheme.BACKGROUND_COLOR.cgColor
        allTextsInView.forEach { (label) in
            label.textColor = CurrentTheme.FONT_COLOR
        }
    }
}
