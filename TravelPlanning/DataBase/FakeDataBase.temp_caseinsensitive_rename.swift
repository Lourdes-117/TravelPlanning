//
//  fakeDataBase.swift
//  TravelPlanning
//
//  Created by Tringapps on 09/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//
import UIKit
import Foundation
class FakeDataBase {
    class func returnJson() -> Any {
        var travelList:[Any] = []
        let from = "from"
        let to  = "to"
        let modeOfTransport = "modeOfTransport"
        let date = "date"
        let reason = "reason"

        let list1: [String: String] = [
                from: "Chennai",
                to: "Hyderabad",
                modeOfTransport: "Flight",
                date: "09/08/2019",
                reason: "To Meet A Friend"
        ]
        let list2: [String: String] = [
            from: "Hyderabad",
            to: "Chennai",
            modeOfTransport: "Flight",
            date: "1/08/2019",
            reason: "Returning Home"
        ]

        travelList.append(list1)
        travelList.append(list2)

        return travelList;
    }
}
