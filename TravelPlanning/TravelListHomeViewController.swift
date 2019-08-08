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
    let pastTravelCell = "pastTravelReusableIdentity"
    var pastTravels:[TravelModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home View Has Been Loaded")
        tableView.dataSource = self
        initializeTravelData()
    }

    func initializeTravelData(){
        pastTravels = SetValueForCells.getPastTravelData()
    }
}
extension TravelListHomeViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastTravels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pastTravelCell) as! TravelCell

        cell.fromLocation.text = pastTravels[indexPath.row].from
        cell.toLocation.text = pastTravels[indexPath.row].to
        cell.dateOfTravel.text = pastTravels[indexPath.row].date
        cell.travelModeImage.image = pastTravels[indexPath.row].travelModeImage
        cell.descriptionOfTravel.text = pastTravels[indexPath.row].description

        return cell
    }
}
