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
        print("View For Header In Section Is Called")
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(expendOrCloseSection(button:)), for: .touchUpInside)
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
        return button;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let heightOfHeader:CGFloat = 35
        return heightOfHeader
    }

    @objc func expendOrCloseSection(button:UIButton){
        let clickedButtonTag = button.tag
        print("The button clicked is of section \(clickedButtonTag)")
        switch clickedButtonTag {
        case 0:
            ExpandedSate.isPastTravelsExpanded = !ExpandedSate.isPastTravelsExpanded
        case 1:
            ExpandedSate.isTodayTravelsExpanded = !ExpandedSate.isTodayTravelsExpanded
        case 2:
            ExpandedSate.isFuruteTravelsExpanded = !ExpandedSate.isFuruteTravelsExpanded
        default:
            print(Errors.UNEXPECTED_INDEX)
        }
        
    }
}
