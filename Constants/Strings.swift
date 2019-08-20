//
//  Strings.swift
//  TravelPlanning
//
//  Created by Tringapps on 12/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

struct DateFormat {
    static let DATE_FORMAT:String = "dd/MM/yyyy"
}

struct TravelDates {
    static let  PAST_TRAVELS:String = "Past Travels"
    static let  TODAY_TRAVELS:String = "Today's Travels"
    static let  FUTURE_TRAVELS:String = "Future Travels"
}

struct ModeOfTransports {
    static let FLIGHT:String = "Flight"
    static let MOTORBIKE:String = "Motorbike"
    static let CAR:String = "Car"
    static let BUS:String =  "Bus"
    static let TRAIN:String =  "Train"
}

struct Errors {
    static let UNEXPECTED_INDEX:String = "Internal Error: Unexpedted Index Found"
    static let INVALID_MODE_OF_TRANSPORT:String = "Internal Error: Invalid Mode Of Transport"
}

struct Regex {
    static let LOCATION:String = "([A-Za-z\\s]){1,}"
    static let REASON:String = "([\\s\\S])"
    static let VALID_DATE:String = "(([0-9]{1,2})[//]([0-9]{1,2})[//]([0-9]{1,4}))"
}

struct RegistrationStatus {
    static let VALID_FIELD:String = "Valid"
    static let INVALID_FIELD:String = "Invalid"
}

struct Defaults {
    static let IS_DATABASE_UPDATED = "isDatabaseUpdated"
}
