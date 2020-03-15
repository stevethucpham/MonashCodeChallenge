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
    func errorDisplay(message: String)
    func reloadTable()
    
}

class HomePresenter {
    
    //    let timeTable: Timetable = load("service.json")
    var timeTable: Timetable?
    let systemService: SystemDerived
    let apiRequest: APIRequestType
    
    weak var display: HomeDisplay? {
        didSet {
            viewInit()
        }
    }
    
    init(systemService: SystemDerived = SystemService(), apiService: APIRequestType = APIRequest()) {
        self.systemService = systemService
        self.apiRequest = apiService
    }
    
    private func viewInit() {
        loadData()
    }
    
    
    func loadData() {
        guard let display = display else { return }
        apiRequest.getSchedules { [weak self] (result) in
            switch result {
            case .success(let timetable):
                guard let strongSelf = self, let timeTable = timetable else { return }
                strongSelf.timeTable = timeTable
                display.reloadTable()
                
                display.set(name: .hey + timeTable.student.name, date: "\(strongSelf.systemService.now.convertToString(dateFormat: "dd/MM EEEE")), Week \(timeTable.week)")
                break
            case .failure(let error):
                display.errorDisplay(message: error?.localizedDescription ?? .unknownError)
                break
            }
        }
    }
    
    func getItems(for section: HomeSection) -> [HomeCellModel] {
        guard let timeTable = timeTable else {
            return []
        }
        switch section {
        case .busSchedule:
            return timeTable.stops
                .filter {
                    systemService.now <= Date($0.predictedArrivalDate, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
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
            return timeTable.schedules
                .filter {
                    systemService.now <= Date($0.startTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
                        && Calendar.current.isDate(systemService.now, inSameDayAs:Date($0.startTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ss"))
                }
                .map {
                return CourseCellModel(
                    startTime: Date($0.startTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ss"),
                    endTime: Date($0.endTime, dateFormat: "yyyy-MM-dd'T'HH:mm:ss") ,
                    course: $0.course + " \($0.scheduleClass)",
                    tutor: $0.lecturer ,
                    location: $0.room  + ", \($0.campus)"
                )
            }.first(elementCount: 3)
        }
    }
    
    func getNumberOfSections() -> Int {
        return HomeSection.allCases.count
    }
    
    func getNumberOfRows(for type: HomeSection) -> Int {
        guard let timeTable = timeTable else {
            return 0
        }
        switch type {
        case .schedule:
            return timeTable.schedules.count > 0 ? 1 : 0
        case .parking:
            return timeTable.parkings.count > 0 ? 1 : 0
        case .busSchedule:
            return timeTable.stops.filter {
                systemService.now <= Date($0.predictedArrivalDate, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
            }.count > 0 ? 1 : 0
        }
    }
}

private extension String {
    
    static let unknownError = NSLocalizedString("Something went wrong", comment: "Unknown error message")
    static let hey = NSLocalizedString("Hey, ", comment: "Student welcome")
}

private extension Array {
    func first(elementCount: Int) -> Array {
          let min = Swift.min(elementCount, count)
          return Array(self[0..<min])
    }
}
