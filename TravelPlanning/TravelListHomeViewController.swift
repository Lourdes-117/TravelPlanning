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
        applyAllThemes()
        tableView.dataSource = self
        tableView.delegate = self
        dispatchGroup.notify(queue: .main, execute: {
            self.stopLoadingActivity()
            self.refreshViewController()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View Will Appear Called")
        applyAllThemes()
        refreshViewController()
    }

    fileprivate func applyAllThemes() {
        navigationController?.navigationBar.barTintColor = CurrentTheme.BACKGROUND_COLOR
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: CurrentTheme.FONT_COLOR!]
        tableView.layer.backgroundColor = CurrentTheme.BACKGROUND_COLOR.cgColor
        view.layer.backgroundColor = CurrentTheme.BACKGROUND_COLOR.cgColor
    }

    fileprivate func startLoadingActivity() {
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    fileprivate func stopLoadingActivity() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }

    func refreshViewController() {
        print("Refreshing TableViewController")
        self.seperateDate()
        self.tableView.reloadData()
    }

    fileprivate func initializeTravelData() {
        let urlToFetchData:String = "https://api.myjson.com/bins/14u2y7"
        if(UserDefaults.standard.bool(forKey: Defaults.IS_DATABASE_UPDATED)) {
            print("Fetching Data From Database")
            setAllTravelsData.getDataFromDatabase()
        } else {
            print("Fetching Data From API")
            setAllTravelsData.getDataFromAPI(urlToFetchData: urlToFetchData, dispatchGroup: dispatchGroup)
        }
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

//tableView DataSource
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
        var travelTime:TravelTime

        switch indexPath.section {
        case 0:
            travelDetailsToShowInSection = pastTravels
            travelTime = TravelTime.Past
        case 1:
            travelDetailsToShowInSection = todayTravels
            travelTime = TravelTime.Today
        case 2:
            travelDetailsToShowInSection = futureTravels
            travelTime = TravelTime.Future
        default:
            travelTime = TravelTime.Past
            print("Internal Error: Invalid Section Accessed")
        }
        cell.setValues(travelDetail: travelDetailsToShowInSection[indexPath.row], travelTime: travelTime)
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
            print("Internal Error: Invalid Section Accessed")
        }
        performSegue(withIdentifier: cellDescriptionSegueIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let travelDecriptionViewController = segue.destination as? TravelDecriptionViewController else {
            return;
        }
        travelDecriptionViewController.selectedTravelDetails = selectedTravelDetail
    }
}

//tableView Delegate
extension TravelListHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        let sectionHeaderButtonFontSize:CGFloat = 16.0
        let sectionHeaderShadowAlpha :CGFloat = 0.8
        let sectionHeaderShadowOpacity:Float = 0.8
        let sectionHeaderShadhowOffsetWidth:CGFloat = 2
        let sectionHeaderShadowOffsetHeight:CGFloat = 8
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: sectionHeaderButtonFontSize)
        button.addTarget(self, action: #selector(expandOrCloseSection), for: .touchUpInside)
        button.tag = section
        switch section {
        case 0:
            button.setTitle(TravelDates.PAST_TRAVELS, for: .normal)
        case 1:
            button.setTitle(TravelDates.TODAY_TRAVELS, for: .normal)
        case 2:
            button.setTitle(TravelDates.FUTURE_TRAVELS, for: .normal)
        default:
            print(Errors.UNEXPECTED_INDEX)
        }
        button.backgroundColor = UIColor.ORANGE
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.withAlphaComponent(sectionHeaderShadowAlpha).cgColor
        button.layer.shadowOffset = CGSize(width: sectionHeaderShadhowOffsetWidth, height: sectionHeaderShadowOffsetHeight)
        button.layer.shadowOpacity = sectionHeaderShadowOpacity
        return button;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let heightOfHeader:CGFloat = 40
        return heightOfHeader
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            switch indexPath.section {
            case 0:
                removeElementFromMainArray(elementToRemove: pastTravels[indexPath.row])
                pastTravels.remove(at: indexPath.row)
            case 1:
                removeElementFromMainArray(elementToRemove: todayTravels[indexPath.row])
                todayTravels.remove(at: indexPath.row)
            case 2:
                removeElementFromMainArray(elementToRemove: futureTravels[indexPath.row])
                futureTravels.remove(at: indexPath.row)
            default:
                print(Errors.UNEXPECTED_INDEX)
            }
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    fileprivate func removeElementFromMainArray(elementToRemove: TravelModel) {
        //Delete From SqlDatabase
        SqliteConnection.deleteTravel(ofID: elementToRemove.id)
        //Delete From Array
        var iterator: Int = 0
        if TravelListHomeViewController.allTravelDetailsMaxId ==  elementToRemove.id {
            TravelListHomeViewController.allTravelDetailsMaxId = TravelListHomeViewController.allTravelDetailsMaxId - 1
        }
        for travelModeIterator in TravelListHomeViewController.allTravels {
            if(travelModeIterator == elementToRemove) {
                print("Deleted ", travelModeIterator)
                print(TravelListHomeViewController.allTravels[iterator])
                TravelListHomeViewController.allTravels.remove(at: iterator)
                break
            }
            iterator = iterator + 1
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

    fileprivate func getIndicesToModify(array:[TravelModel], section:Int) -> [IndexPath] {
        var indexPathsToReturn:[IndexPath] = []
        for row in array.indices {
            let indexPathToAppend = IndexPath(row: row, section: section)
            indexPathsToReturn.append(indexPathToAppend)
        }
        return indexPathsToReturn
    }
}

