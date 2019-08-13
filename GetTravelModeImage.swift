//
//  GetTravelModeImage.swift
//  TravelPlanning
//
//  Created by Tringapps on 13/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
class GetTravelModeImage {
    class func getImage(ofString modeOfTransport:String) -> UIImage {
        switch modeOfTransport {
        case ModeOfTransports.FLIGHT.rawValue:
            return #imageLiteral(resourceName: "flight-Icon")
        case ModeOfTransports.MOTORBIKE.rawValue:
            return #imageLiteral(resourceName: "bike-Icon")
        case ModeOfTransports.CAR.rawValue:
            return #imageLiteral(resourceName: "car-Icon")
        case ModeOfTransports.BUS.rawValue:
            return #imageLiteral(resourceName: "bus-Icon")
        case ModeOfTransports.TRAIN.rawValue:
            return #imageLiteral(resourceName: "train-icon")
        default:
            print()
        }
        return #imageLiteral(resourceName: "flight-Icon")
    }
}
