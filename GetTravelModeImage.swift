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
        case ModeOfTransports.FLIGHT:
            return #imageLiteral(resourceName: "flight-Icon")
        case ModeOfTransports.MOTORBIKE:
            return #imageLiteral(resourceName: "bike-Icon")
        case ModeOfTransports.CAR:
            return #imageLiteral(resourceName: "car-Icon")
        case ModeOfTransports.BUS:
            return #imageLiteral(resourceName: "bus-Icon")
        case ModeOfTransports.TRAIN:
            return #imageLiteral(resourceName: "train-icon")
        default:
            print()
        }
        return #imageLiteral(resourceName: "flight-Icon")
    }

    class func getString(ofImage modeOfTransport:UIImage) -> String {
        switch modeOfTransport {
        case #imageLiteral(resourceName: "flight-Icon"):
            return ModeOfTransports.FLIGHT
        case #imageLiteral(resourceName: "bike-Icon"):
            return ModeOfTransports.MOTORBIKE
        case #imageLiteral(resourceName: "car-Icon"):
            return ModeOfTransports.CAR
        case #imageLiteral(resourceName: "bus-Icon"):
            return ModeOfTransports.BUS
        case #imageLiteral(resourceName: "train-icon"):
            return ModeOfTransports.TRAIN
        default:
            print()
        }
        return ModeOfTransports.FLIGHT
    }
}
