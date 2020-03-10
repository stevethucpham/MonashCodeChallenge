//
//  Schedule.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

// MARK: - Timetable
struct Timetable: Codable {
    let schedules: [Schedule]?
    let parkingSlot: Int
    let stops: [Stop]?

    enum CodingKeys: String, CodingKey {
        case schedules
        case parkingSlot = "parking_slot"
        case stops
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let startTime, endTime, course, scheduleClass: String
    let lecturer, room, campus: String

    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case endTime = "end_time"
        case course
        case scheduleClass = "class"
        case lecturer, room, campus
    }
}


// MARK: - Stop
struct Stop: Codable {
    let departure, arrival: String
    let predictedArrivalDate: Date

    enum CodingKeys: String, CodingKey {
        case departure, arrival
        case predictedArrivalDate = "predicted_arrival_date"
    }
}
