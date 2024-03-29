//
//  DateSeperator.swift
//  TravelPlanning
//
//  Created by Tringapps on 12/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
class DateSeperator {
    class func seperateDates(allTravels:[TravelModel]) -> ([TravelModel], [TravelModel], [TravelModel]){
        var pastTravels: [TravelModel] = []
        var todayTravels: [TravelModel] = []
        var futureTravels: [TravelModel] = []

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.DATE_FORMAT

        let todayDateString = dateFormatter.string(from: date)
        let todayDate = dateFormatter.date(from:todayDateString)!
        for travel in allTravels {
            let date = dateFormatter.date(from:travel.date)!
            if(todayDate > date) {
                pastTravels.append(travel)
            } else if (todayDate == date) {
                todayTravels.append(travel)
            } else {
                futureTravels.append(travel)
            }
        }
        return (pastTravels, todayTravels, futureTravels)
    }
}
