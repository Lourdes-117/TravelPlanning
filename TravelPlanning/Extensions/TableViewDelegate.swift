//
//  TableViewDelegate.swift
//  TravelPlanning
//
//  Created by Tringapps on 12/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
extension TravelListHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(expandOrCloseSection), for: .touchUpInside)
        button.tag = section
        switch section {
        case 0:
            button.setTitle(TravelDates.PAST_TRAVELS.rawValue, for: .normal)
        case 1:
            button.setTitle(TravelDates.TODAY_TRAVELS.rawValue, for: .normal)
        case 2:
            button.setTitle(TravelDates.FUTURE_TRAVELS.rawValue, for: .normal)
        default:
            print(Errors.UNEXPECTED_INDEX)
        }
        button.backgroundColor = Colors.DARK_BLUE
        return button;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let heightOfHeader:CGFloat = 40
        return heightOfHeader
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            switch indexPath.section
            {
            case 0:
                pastTravels.remove(at: indexPath.row)
            case 1:
                todayTravels.remove(at: indexPath.row)
            case 2:
                futureTravels.remove(at: indexPath.row)
            default:
                print(Errors.UNEXPECTED_INDEX)
            }
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    @objc func expandOrCloseSection(button:UIButton){
        var indexPathsToModify:[IndexPath] = []
        let clickedButtonTag = button.tag
        var isExpanding:Bool = true
        print("The button clicked is of section \(clickedButtonTag)")
        switch clickedButtonTag {
        case 0:
            ExpandedSate.isPastTravelsExpanded = !ExpandedSate.isPastTravelsExpanded
            isExpanding = ExpandedSate.isPastTravelsExpanded
            indexPathsToModify = getIndicesToModify(array: pastTravels, section: 0)

        case 1:
            ExpandedSate.isTodayTravelsExpanded = !ExpandedSate.isTodayTravelsExpanded
            isExpanding = ExpandedSate.isTodayTravelsExpanded

            indexPathsToModify = getIndicesToModify(array: todayTravels, section: 1)
            
        case 2:
            ExpandedSate.isFuruteTravelsExpanded = !ExpandedSate.isFuruteTravelsExpanded
            isExpanding = ExpandedSate.isFuruteTravelsExpanded
            indexPathsToModify = getIndicesToModify(array: futureTravels, section: 2)

        default:
            print(Errors.UNEXPECTED_INDEX)
        }
        if(!isExpanding) {
            tableView.deleteRows(at: indexPathsToModify, with: .fade)
        } else {
            tableView.insertRows(at: indexPathsToModify, with: .fade)
        }
    }

    func getIndicesToModify(array:[TravelModel], section:Int) -> [IndexPath] {
        var indexPathsToReturn:[IndexPath] = []
        for row in array.indices {
            let indexPathToAppend = IndexPath(row: row, section: section)
            indexPathsToReturn.append(indexPathToAppend)
        }
        return indexPathsToReturn
    }
}
