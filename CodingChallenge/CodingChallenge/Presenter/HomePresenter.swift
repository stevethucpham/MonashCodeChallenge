//
//  HomePresenter.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

enum HomeSection: CaseIterable {
    case schedule
    case parking
    case busSchedule
    
    var title: String {
        switch self {
        
        case .parking:
            return "Available car parks"
        case .busSchedule:
            return "Intercampus Shuttle Bus"
        default:
            return ""
        }
    }
    
    static let cellIdentifier = "CourseCell"
    
}

protocol HomeDisplay: class {
    func set(name: String, date: String)
    
}

class HomePresenter {

    let timeTable: Timetable = load("service.json")
    
    weak var display: HomeDisplay? {
        didSet {
            viewInit()
        }
    }
    
    private func viewInit() {
        guard let display = display else { return }
        display.set(name: .hey + "Kier", date: "17/05 Tuesday, Week 8")
    }
    
    
    func getItems(for section: HomeSection) -> [HomeCellModel] {
        switch section {
        case .busSchedule:
            return timeTable.stops.map {
                return BusCellModel (
                    departure: $0.departure,
                    arrival: $0.arrival,
                    predictedTime: $0.predictedArrivalDate
                )
            }
        case .parking:
            return timeTable.parkings.map {
                return ParkingCellModel(
                    parkingName: $0.name,
                    parkingSlots: $0.slot
                )
            }
        case .schedule:
            return timeTable.schedules.map {
                return CourseCellModel(
                    startTime: $0.startTime ,
                    endTime: $0.endTime ,
                    course: $0.name ,
                    tutor: $0.lecturer ,
                    location: $0.room  + ", \($0.campus)"
                )
            }
        }
    }
    
    func getNumberOfSections() -> Int {
        return HomeSection.allCases.count
    }
    
    func getNumberOfRows(for type: HomeSection) -> Int {
        switch type {
        case .schedule:
            return timeTable.schedules.count
        case .parking:
            return timeTable.parkings.count
        case .busSchedule:
            return timeTable.stops.count
        }
    }
}

private extension String {
    
    static let hey = NSLocalizedString("Hey, ", comment: "Student welcome")
}
