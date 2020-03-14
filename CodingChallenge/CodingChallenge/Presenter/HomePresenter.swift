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
    let systemService: SystemDerived
    
    weak var display: HomeDisplay? {
        didSet {
            viewInit()
        }
    }
    
    init(systemService: SystemDerived = SystemService()) {
        self.systemService = systemService
    }
    
    private func viewInit() {
        guard let display = display else { return }
        
        display.set(name: .hey + timeTable.student.name, date: "\(systemService.now.convertToString(dateFormat: "dd/MM EEEE")), Week \(timeTable.week)")
    }
    
    
    func getItems(for section: HomeSection) -> [HomeCellModel] {
        switch section {
        case .busSchedule:
            return timeTable.stops
                .filter {
                    systemService.now < Date($0.predictedArrivalDate, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
            }
            .map {
                return BusCellModel (
                    departure: $0.departure,
                    arrival: $0.arrival,
                    predictedDateTime: Date($0.predictedArrivalDate, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
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
                    startTime: Date($0.startTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ss"),
                    endTime: Date($0.endTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ss") ,
                    course: $0.course + " \($0.scheduleClass)",
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
            return timeTable.schedules.count > 0 ? 1 : 0
        case .parking:
            return timeTable.parkings.count > 0 ? 1 : 0
        case .busSchedule:
            return timeTable.stops.filter {
                systemService.now < Date($0.predictedArrivalDate, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
            }.count > 0 ? 1 : 0
        }
    }
}

private extension String {
    
    static let hey = NSLocalizedString("Hey, ", comment: "Student welcome")
}
