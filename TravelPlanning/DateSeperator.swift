//
//  DateSeperator.swift
//  TravelPlanning
//
//  Created by Tringapps on 12/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
class DateSeperator {
    class func seperateDate(allTravels:[TravelModel]) -> ([TravelModel], [TravelModel], [TravelModel]){
        var pastTravels: [TravelModel] = []
        var todayTravels: [TravelModel] = []
        var futureTravels: [TravelModel] = []

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.DATE_FORMAT.rawValue

        let todayDate = dateFormatter.string(from: date)
        for travel in allTravels {
            if(todayDate > travel.date) {
                pastTravels.append(travel)
            } else if (todayDate == travel.date) {
                todayTravels.append(travel)
            } else {
                futureTravels.append(travel)
            }
        }
        return (pastTravels, todayTravels, futureTravels)
    }
}
