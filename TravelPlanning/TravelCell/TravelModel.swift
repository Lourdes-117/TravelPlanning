//
//  TravelModel.swift
//  TravelPlanning
//
//  Created by Tringapps on 08/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
struct TravelModelDecodable: Decodable, Equatable {
    var id:Int!
    var modeOfTransport:String!
    var from:String!
    var to:String!
    var date:String!
    var reason:String!
}
