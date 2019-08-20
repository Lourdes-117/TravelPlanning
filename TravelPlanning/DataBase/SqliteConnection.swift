//
//  SqliteConnection.swift
//  TravelPlanning
//
//  Created by Tringapps on 20/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

import Foundation
import SQLite

class SqliteConnection {
    private init(){}
    private static let sqliteConnectionObject = SqliteConnection()
    public static func getInstance() -> SqliteConnection {
        return sqliteConnectionObject
    }

    static private let travelsTable = Table(Database.travelsTable)

    static var databaseConnection: Connection!

    public static func initializeDatabase() {
        do {
             let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(Database.travelsDatabase).appendingPathExtension(Database.sqlite3Extension)
            databaseConnection = try Connection(fileUrl.path )
            print("Initialized Database")
        } catch {
            print("Database Error ", error)
        }
        createTableIfNeeded()
    }

    public static func createTableIfNeeded() {
        let createTable = travelsTable.create { (table) in
            table.column(Database.Expressions.id, unique: true)
            table.column(Database.Expressions.fromLocation)
            table.column(Database.Expressions.toLocation)
            table.column(Database.Expressions.modeOfTransport)
            table.column(Database.Expressions.dateOfTravel)
            table.column(Database.Expressions.reason)
        }
        do {
            try SqliteConnection.databaseConnection.run(createTable)
            print("Creating New Table")
        } catch {
            print("Table Exists: Using Existing Table")
        }
    }

    public static func insertRow(withDetails travelModels: [TravelModel]) {
        for travelModel in travelModels {
            let insertUser = travelsTable.insert(Database.Expressions.id <- travelModel.id,
                                                 Database.Expressions.fromLocation <- travelModel.from,
                                                 Database.Expressions.toLocation <- travelModel.to,
                                                 Database.Expressions.modeOfTransport <- travelModel.modeOfTransport,
                                                 Database.Expressions.dateOfTravel <- travelModel.date,
                                                 Database.Expressions.reason <- travelModel.reason)
            do {
                try databaseConnection.run(insertUser)
                print("Inserted New Travel Details")
            } catch {
                print("Error In Inserting Element ", error)
            }
        }
    }

    public static func getAllRows() -> AnySequence<Row>? {
        print("Returning All Rows In Table")
        do {
            let travels = try databaseConnection.prepare(travelsTable)
            return travels
        } catch {
            print("Data Fetch Error ", error )
        }
        return nil
    }

    public static func updateTravel(ofId travelIDToEdit: Int, with travelModel: TravelModel) {
        let travelToUpdate = travelsTable.filter(Database.Expressions.id == travelIDToEdit)
        let updateUser = travelToUpdate.update(Database.Expressions.fromLocation <- travelModel.from,
                                                 Database.Expressions.toLocation <- travelModel.to,
                                                 Database.Expressions.modeOfTransport <- travelModel.modeOfTransport,
                                                 Database.Expressions.dateOfTravel <- travelModel.date,
                                                 Database.Expressions.reason <- travelModel.reason)
        do {
            try databaseConnection.run(updateUser)
            print("Travel Details Updated")
        } catch {
            print("Error In Updating Data ",error)
        }
    }

    public static func deleteTravel(ofID travelIDToDelete: Int) {
        let travelToDelete = travelsTable.filter(travelIDToDelete == Database.Expressions.id)
        let deleteTravel = travelToDelete.delete()
        do {
            try databaseConnection.run(deleteTravel)
            print("User Details Deleted")
        } catch {
            print("Error In Deleting Entry ",error)
        }
    }
}
