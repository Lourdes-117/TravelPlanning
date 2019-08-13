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
            print("Internal Error: Invalid Sexrion Accessed")
        }
        cell.setValues(travelDetail: travelDetailsToShowInSection[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0:
            selectedTravelDetail = pastTravels[indexPath.row]
        case 1:
            selectedTravelDetail = todayTravels[indexPath.row]
        case 2:
            selectedTravelDetail = futureTravels[indexPath.row]
        default:
            print("Internal Error: Invalid Sexrion Accessed")
        }
        performSegue(withIdentifier: cellDescriptionSegueIdentifier, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let travelDecriptionViewController = segue.destination as? TravelDecriptionViewController else {
            return;
        }
        travelDecriptionViewController.travelDetails = selectedTravelDetail
    }
}
