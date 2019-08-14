//
//  TravelModel.swift
//  TravelPlanning
//
//  Created by Tringapps on 08/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import UIKit
struct TravelModel: Decodable, Equatable {
    var modeOfTransport:String!
    var from:String!
    var to:String!
    var date:String!
    var reason:String!
    init(mode:String, from:String, to:String, date:String, reason:String) {
        self.modeOfTransport = mode
        self.from = from
        self.to = to
        self.date = date
        self.reason = reason
    }

    static func == (left: TravelModel, right: TravelModel) -> Bool{
        return (left.date == right.date) && (left.reason == right.reason) && (left.from == right.from) && (left.to == right.to) && (left.modeOfTransport == right.modeOfTransport)
    }

    init(){}
}
