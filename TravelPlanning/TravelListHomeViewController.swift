//
//  ViewController.swift
//  TravelPlanning
//
//  Created by Tringapps on 08/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit

class TravelListHomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let TravelCell = "TravelReusableIdentity"
    var allTravels:[TravelModel] = []

    var pastTravels:[TravelModel] = []
    var todayTravels:[TravelModel] = []
    var futureTravels:[TravelModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home View Has Been Loaded")
        initializeFakeTravelDate()
        tableView.dataSource = self
        tableView.delegate = self
        seperateDate()
    }

    func initializeTravelData(){
        allTravels = getData.getAllTravels()
    }

    func initializeFakeTravelDate() {
        var travel1 = TravelModel()
        travel1.from = "From1"
        travel1.to = "To"
        travel1.date = "12/01/2019"
        travel1.modeOfTransport = "Mode"
        travel1.reason = "Reason"

        var travel2 = TravelModel()
        travel2.from = "From2"
        travel2.to = "To2"
        travel2.date = "12/08/2019"
        travel2.modeOfTransport = "Mode2"
        travel2.reason = "Reason2"

        var travel3 = TravelModel()
        travel3.from = "travel3"
        travel3.to = "To3"
        travel3.date = "13/08/2019"
        travel3.modeOfTransport = "Mode3"
        travel3.reason = "Reason3"

        var travel4 = TravelModel()
        travel4.from = "From4"
        travel4.to = "To4"
        travel4.date = "11/08/2019"
        travel4.modeOfTransport = "Mode4"
        travel4.reason = "Reason4"

        var travel5 = TravelModel()
        travel5.from = "From5"
        travel5.to = "To5"
        travel5.date = "18/08/2019"
        travel5.modeOfTransport = "Mode5"
        travel5.reason = "Reason5"

        var travel6 = TravelModel()
        travel6.from = "From6"
        travel6.to = "To6"
        travel6.date = "20/12/2019"
        travel6.modeOfTransport = "Mode6"
        travel6.reason = "Reason6"

        var travel7 = TravelModel()
        travel7.from = "From7"
        travel7.to = "To7"
        travel7.date = "Date7"
        travel7.modeOfTransport = "Mode7"
        travel7.reason = "01/10/2020"

        allTravels.append(travel1)
        allTravels.append(travel2)
        allTravels.append(travel3)
        allTravels.append(travel4)
        allTravels.append(travel5)
        allTravels.append(travel6)
        allTravels.append(travel7)
    }

    func seperateDate() {
        (pastTravels, todayTravels, futureTravels) = DateSeperator.seperateDate(allTravels: allTravels)
    }
}
