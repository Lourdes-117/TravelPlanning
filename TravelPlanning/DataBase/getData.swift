//
//  getJson.swift
//  TravelPlanning
//
//  Created by Tringapps on 09/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
struct country:Decodable {
    var name:String
    var capital:String
    var region:String
}

class getData {
    class func getAllTravels(dispatchGroup:DispatchGroup) -> [TravelModel] {
        dispatchGroup.enter();
        var tempTravelModel: TravelModel!
        var travelArray:[TravelModel] = []
        let url = "https://api.myjson.com/bins/14u2y7"
        let urlObject = URL(string: url)
//        let fileName:String = "allTravelsDataApi"
//        let fileExtension:String = "json"
//        let urlObject = Bundle.main.url(forResource: fileName, withExtension: fileExtension)

        URLSession.shared.dataTask(with: urlObject!) {(data, response, error) in
            print("This is working")
            do {
                guard let data = data else{return}
                let travels = try JSONDecoder().decode([TravelModel].self, from: data)
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
                    travelArray.append(tempTravelModel)
                    TravelListHomeViewController.allTravels.append(tempTravelModel);
                }
            } catch {
                print("Error: \(error)")
            }
            dispatchGroup.leave();
        }.resume()
        print("Returning the objects")
        return travelArray;
    }
}
