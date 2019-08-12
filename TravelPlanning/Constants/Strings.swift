//
//  Strings.swift
//  TravelPlanning
//
//  Created by Tringapps on 12/08/19.
//  Copyright © 2019 Tringapps. All rights reserved.
//

enum DateFormat:String {
    case DATE_FORMAT = "dd/MM/yyyy"
}
enum TravelDates:String {
    case PAST_TRAVELS = "Past Travels"
    case TODAY_TRAVELS = "Today's Travels"
    case FUTURE_TRAVELS = "Future Travels"
}

enum ModeOfTransports:String {
    case FLIGHT = "Flight"
    case MOTORBIKE = "Motorbike"
    case CAR = "Car"
    case BUS =  "Bus"
    case TRAIN =  "Train"
}
enum Errors:String {
    case UNEXPECTED_INDEX = "Internal Error: Unexpedted Index Found"
    case INVALID_MODE_OF_TRANSPORT = "Internal Error: Invalid Mode Of Transport"
}
