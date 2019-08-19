//
//  getJson.swift
//  TravelPlanning
//
//  Created by Tringapps on 09/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
class getData {
    class func getJsonArray<T: Decodable>(fromUrl url:String, dispatchGroup:DispatchGroup, completion:@escaping (T)->Void) {
        dispatchGroup.enter();
//        let fileName:String = "allTravelsDataApi"
//        let fileExtension:String = "json"
//        let urlObject = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        let urlObject = URL(string: url)
        URLSession.shared.dataTask(with: urlObject!) {(data, response, error) in
            do {
                guard let data = data else{return}
                let jsonArray = try JSONDecoder().decode(T.self, from: data)
                completion(jsonArray);
                
            } catch {
                print("Error in Fetching Data: \(error)")
            }
            dispatchGroup.leave();
        }.resume()
    }
}
