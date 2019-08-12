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
    class func getAllTravels() -> [TravelModel] {
        var tempTravelModel: TravelModel!
        var travelArray:[TravelModel] = []
        let url = "https://anotherapi.000webhostapp.com/jsonresponse.json"
        let urlObject = URL(string: url)

        URLSession.shared.dataTask(with: urlObject!) {(data, response, error) in
            print("This is working")
            do {
                guard let data = data else{return}
                let travels = try JSONDecoder().decode([TravelModel].self, from: data)
                print(travels)
                for travel in travels {
                    tempTravelModel = TravelModel(mode: travel.modeOfTransport!, from: travel.from, to: travel.to, date: travel.date, reason: travel.reason)
                    travelArray.append(tempTravelModel)
                }
                print(travelArray.count)
            } catch {
                print(error)
            }
        }
        print("Returning the objects")
        print(travelArray.count)
        return travelArray;
    }
}
