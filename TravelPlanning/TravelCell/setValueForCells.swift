//
//  setValueForCells.swift
//  TravelPlanning
//
//  Created by Tringapps on 08/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
class SetValueForCells {
    class func getPastTravelData() -> [TravelModel] {
        var travelList:[TravelModel] = []
        let travel1 = TravelModel();
        travel1.from = "Chennai"
        travel1.to = "Hydrabad"
        travel1.date = "09/08/2019"
        travel1.description = "To Meet A Friend who"
        travel1.travelModeImage = #imageLiteral(resourceName: "flight-Icon")

        let travel2 = TravelModel();
        travel2.from = "Hydrabad"
        travel2.to = "Chennai"
        travel2.date = "11/08/2019"
        travel2.description = "Returning Home"
        travel2.travelModeImage = #imageLiteral(resourceName: "flight-Icon")

        let travel3 = TravelModel();
        travel3.from = "Somewhere"
        travel3.to = "Nowhere"
        travel3.date = "11/08/2019"
        travel3.description = "Returning Home"
        travel3.travelModeImage = #imageLiteral(resourceName: "flight-Icon")

        travelList.append(travel1)
        travelList.append(travel2)
        travelList.append(travel3)
        return travelList;
    }
}
