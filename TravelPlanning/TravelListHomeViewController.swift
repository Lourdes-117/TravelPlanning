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
    let cellDescriptionSegueIdentifier:String = "CellDescriptionSegueIdentifier"
    let addNewEntrySegueIdentifier:String = "AddNewEntrySegueIdentifier"
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    let dispatchGroup = DispatchGroup()
    var selectedTravelDetail:TravelModel!

    static var allTravels:[TravelModel] = []
    static var allTravelDetailsMaxId:Int = 0

    var pastTravels:[TravelModel] = []
    var todayTravels:[TravelModel] = []
    var futureTravels:[TravelModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home View Has Been Loaded")
        startLoadingActivity()
        initializeTravelData()
        tableView.dataSource = self
        tableView.delegate = self
        dispatchGroup.notify(queue: .main, execute: {
            print("Network Request in complete");
            self.stopLoadingActivity()
            self.refreshViewController()
            })
    }

    func startLoadingActivity(){
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    func stopLoadingActivity(){
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View Will Appear Called")
        refreshViewController()
    }

    func refreshViewController() {
        print("Refreshing TableViewController")
        self.seperateDate()
        self.tableView.reloadData()
    }

    func initializeTravelData(){
        TravelListHomeViewController.allTravels = getData.getAllTravels(dispatchGroup: dispatchGroup)
    }
    
    @IBAction func onClickAddAnotherTravel(_ sender: Any) {
        performSegue(withIdentifier: addNewEntrySegueIdentifier, sender: self)
    }

    func seperateDate() {
        (pastTravels, todayTravels, futureTravels) = DateSeperator.seperateDate(allTravels: TravelListHomeViewController.allTravels)
    }

    @IBAction func unwindToTravelListHomeViewController(_ unwindSegue: UIStoryboardSegue) {
        print("Segue Unwinded To Home Controller")
        refreshViewController();
    }

    deinit {
        print("Travel List Page is Safe From Memory Leaks")
    }
}
