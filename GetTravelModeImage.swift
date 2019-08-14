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

    class func getString(ofImage modeOfTransport:UIImage) -> String {
        switch modeOfTransport {
        case #imageLiteral(resourceName: "flight-Icon"):
            return ModeOfTransports.FLIGHT.rawValue
        case #imageLiteral(resourceName: "bike-Icon"):
            return ModeOfTransports.MOTORBIKE.rawValue
        case #imageLiteral(resourceName: "car-Icon"):
            return ModeOfTransports.CAR.rawValue
        case #imageLiteral(resourceName: "bus-Icon"):
            return ModeOfTransports.BUS.rawValue
        case #imageLiteral(resourceName: "train-icon"):
            return ModeOfTransports.TRAIN.rawValue
        default:
            print()
        }
        return ModeOfTransports.FLIGHT.rawValue
    }
}
