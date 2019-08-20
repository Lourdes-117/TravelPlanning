//
//  Database.swift
//  TravelPlanning
//
//  Created by Tringapps on 20/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
import SQLite
struct Database {
    public static let travelsDatabase = "travelsDatabase"
    public static let travelsTable = "travels"
    public static let sqlite3Extension = "sqlite3"
    public static let id = "id"
    public static let fromLocation = "fromLocation"
    public static let toLocation = "toLocation"
    public static let modeOfTransport = "modeOfTravel"
    public static let dateOfTravel = "dateOfTravel"
    public static let reason = "reason"
    struct Expressions {
        static public let id = Expression<Int>(Database.id)
        static public let fromLocation = Expression<String?>(Database.fromLocation)
        static public let toLocation = Expression<String>(Database.toLocation)
        static public let modeOfTransport = Expression<String>(Database.modeOfTransport)
        static public let dateOfTravel = Expression<String>(Database.dateOfTravel)
        static public let reason = Expression<String>(Database.reason)
    }
}
