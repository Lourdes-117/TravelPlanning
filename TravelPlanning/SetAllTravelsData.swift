//
//  setAllTravelsData.swift
//  TravelPlanning
//
//  Created by Tringapps on 20/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
import CoreData

class setAllTravelsData {
    public class func getDataFromDatabase() {
        let travels = SqliteConnection.getAllRows()
        var tempTravelModel:TravelModel = TravelModel()
        guard let travelsUnwrapped = travels else {
            print("Database Error")
            return;
        }
        for travel in travelsUnwrapped {
            if(TravelListHomeViewController.allTravelDetailsMaxId < travel[Database.Expressions.id]){
                TravelListHomeViewController.allTravelDetailsMaxId = travel[Database.Expressions.id]
            }
            tempTravelModel.id = travel[Database.Expressions.id]
            tempTravelModel.modeOfTransport = travel[Database.Expressions.modeOfTransport]
            tempTravelModel.from = travel[Database.Expressions.fromLocation]
            tempTravelModel.to = travel[Database.Expressions.toLocation]
            tempTravelModel.date = travel[Database.Expressions.dateOfTravel]
            tempTravelModel.reason = travel[Database.Expressions.reason]
//            TravelListHomeViewController.allTravels.append(tempTravelModel)
        }
    }

    public class func getDataFromCoreData() {
        print("Fetching Data From Core Data")
        let fetchRequest: NSFetchRequest<Travels > = Travels.fetchRequest()
        do {
            let travelDataFromCoreData = try PersistantService.context.fetch(fetchRequest)
            TravelListHomeViewController.allTravels.append(contentsOf: travelDataFromCoreData)
            }
        catch {
            print("Error In Fetching Data From Core Data ")
        }
    }

    public class func getDataFromAPI(urlToFetchData:String, dispatchGroup: DispatchGroup) {
        UserDefaults.standard.set(true, forKey: Defaults.IS_DATABASE_UPDATED)
        SqliteConnection.deleteAllTravels()
        TravelListHomeViewController.allTravels.removeAll()
        ApiCall.getJsonArrayFromApi(fromUrl: urlToFetchData, dispatchGroup: dispatchGroup, completion: {
            (travels: [TravelModel]) in
            var tempTravelModel: TravelModel = TravelModel()
            for travel in travels {
                if(TravelListHomeViewController.allTravelDetailsMaxId < travel.id) {
                    TravelListHomeViewController.allTravelDetailsMaxId = travel.id
                }
                tempTravelModel.id = travel.id
                tempTravelModel.modeOfTransport = travel.modeOfTransport
                tempTravelModel.from = travel.from
                tempTravelModel.to = travel.to
                tempTravelModel.date = travel.date
                tempTravelModel.reason = travel.reason
//                TravelListHomeViewController.allTravels.append(tempTravelModel);

                let travelCoreData = Travels(context: PersistantService.context)
                travelCoreData.id = Int16(travel.id)
                travelCoreData.fromLocation = travel.from
                travelCoreData.toLocation = travel.to
                travelCoreData.modeOfTransport = travel.modeOfTransport
                travelCoreData.date = travel.date
                travelCoreData.reason = travel.reason
                TravelListHomeViewController.allTravels.append(travelCoreData)
                PersistantService.saveContext()
                print("Saved In Core Data ")
            }
            let fetchRequest: NSFetchRequest<Travels > = Travels.fetchRequest()
            do {
                let travelDataFromCoreData = try PersistantService.context.fetch(fetchRequest)
                for travel in travelDataFromCoreData {
                    print(Int(travel.id))
                    print(travel.fromLocation)
                    print(travel.toLocation)
                    print(travel.modeOfTransport)
                    print(travel.date)
                    print(travel.reason)
                }
            } catch {
                print("Error In Fetching Data From Core Data ")
            }
//            SqliteConnection.insertRow(withDetails: TravelListHomeViewController.allTravels)
        });
    }
}
