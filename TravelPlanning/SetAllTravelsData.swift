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
        TravelListHomeViewController.allTravels.removeAll()
        ApiCall.getJsonArrayFromApi(fromUrl: urlToFetchData, dispatchGroup: dispatchGroup, completion: {
            (travels: [TravelModel]) in
            for travel in travels {
                if(TravelListHomeViewController.allTravelDetailsMaxId < travel.id) {
                    TravelListHomeViewController.allTravelDetailsMaxId = travel.id
                }
                let travelCoreData = Travels(context: PersistantService.context)
                travelCoreData.id = Int16(travel.id)
                travelCoreData.fromLocation = travel.fromLocation
                travelCoreData.toLocation = travel.toLocation
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
        });
    }
}
