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

    fileprivate func startLoadingActivity(){
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    fileprivate func stopLoadingActivity(){
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

    fileprivate func initializeTravelData() {
        let urlToFetchData:String = "https://api.myjson.com/bins/14u2y7"
        getData.getJsonArray(fromUrl: urlToFetchData, dispatchGroup: dispatchGroup, completion: {
            (travels: [TravelModel]) in
            var tempTravelModel: TravelModel!
            for travel in travels {
                if(TravelListHomeViewController.allTravelDetailsMaxId < travel.id){
                    TravelListHomeViewController.allTravelDetailsMaxId = travel.id
                }
                tempTravelModel = TravelModel()
                tempTravelModel.id = travel.id
                tempTravelModel.modeOfTransport = travel.modeOfTransport
                tempTravelModel.from = travel.from
                tempTravelModel.to = travel.to
                tempTravelModel.date = travel.date
                tempTravelModel.reason = travel.reason
                TravelListHomeViewController.allTravels.append(tempTravelModel);
            }
        });
    }
    
    @IBAction func onClickAddAnotherTravel(_ sender: Any) {
        performSegue(withIdentifier: addNewEntrySegueIdentifier, sender: self)
    }

    fileprivate func seperateDate() {
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
