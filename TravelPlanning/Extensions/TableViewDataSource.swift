//
//  TableViewDataSource.swift
//  TravelPlanning
//
//  Created by Tringapps on 12/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

extension TravelListHomeViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = 3
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if !ExpandedSate.isPastTravelsExpanded {return 0}
            return pastTravels.count
        case 1:
            if !ExpandedSate.isTodayTravelsExpanded {return 0}
            return todayTravels.count
        case 2:
            if !ExpandedSate.isFuruteTravelsExpanded {return 0}
           return futureTravels.count;
        default:
            print("Internal Error: More Sections Found")
        }
        return 0 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelCell) as! TravelCell
        var travelDetailsToShowInSection:[TravelModel] = []

        switch indexPath.section {
        case 0:
            travelDetailsToShowInSection = pastTravels
        case 1:
            travelDetailsToShowInSection = todayTravels
        case 2:
            travelDetailsToShowInSection = futureTravels
        default:
            print("Internal Error: More Sections Found")
        }


        cell.fromLocation.text = travelDetailsToShowInSection[indexPath.row].from
        cell.toLocation.text = travelDetailsToShowInSection[indexPath.row].to
        cell.dateOfTravel.text = travelDetailsToShowInSection[indexPath.row].date
        //        cell.travelModeImage.image = travelDetailsToShowInSection[indexPath.row].travelModeImage
        //TEMP
        cell.travelModeImage.image = #imageLiteral(resourceName: "flight-Icon")
        //
        cell.descriptionOfTravel.text = travelDetailsToShowInSection[indexPath.row].reason
        return cell
    }
}
