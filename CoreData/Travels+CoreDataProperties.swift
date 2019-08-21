//
//  Travels+CoreDataProperties.swift
//  TravelPlanning
//
//  Created by Tringapps on 21/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//
//

import Foundation
import CoreData


extension Travels {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Travels> {
        return NSFetchRequest<Travels>(entityName: "Travels")
    }

    @NSManaged public var id: Int16
    @NSManaged public var fromLocation: String
    @NSManaged public var toLocation: String
    @NSManaged public var modeOfTransport: String
    @NSManaged public var date: String
    @NSManaged public var reason: String

}
