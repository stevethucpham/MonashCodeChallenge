//
//  Schedule.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

protocol HomeCellModel {
    
}

// MARK: - Timetable
struct Timetable: Decodable {
    let schedules: [Schedule]
    let parkings: [Parking]
    let stops: [Stop]

    enum CodingKeys: String, CodingKey {
        case schedules
        case parkings
        case stops
    }
}

// MARK: - Schedule
struct Schedule: Decodable {
    let startTime, endTime, name, scheduleClass: String
    let lecturer, room, campus: String

    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case endTime = "end_time"
        case name
        case scheduleClass = "class"
        case lecturer, room, campus
    }
}

struct Parking: Decodable {
    let name: String
    let slot: Int
}


// MARK: - Stop
struct Stop: Decodable {
    let departure, arrival: String
    let predictedArrivalDate: String

    enum CodingKeys: String, CodingKey {
        case departure, arrival
        case predictedArrivalDate = "predicted_arrival_date"
    }
}
