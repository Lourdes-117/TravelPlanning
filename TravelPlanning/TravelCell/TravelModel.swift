//
//  TravelModel.swift
//  TravelPlanning
//
//  Created by Tringapps on 08/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
struct TravelModel: Decodable, Equatable {
    var id:Int!
    var modeOfTransport:String!
    var fromLocation:String!
    var toLocation:String!
    var date:String!
    var reason:String!
}
