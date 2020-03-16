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


/// Delegate to bind UI to view controller
protocol HomeDisplay: class {
    
    /// Set the value for navigation title view
    /// - Parameters:
    ///   - name: Student name
    ///   - date: Current date
    func set(name: String, date: String)
    
    /// Display error messag if something went wrong
    /// - Parameter message: Error message
    func errorDisplay(message: String)
    
    /// Reload the table callback
    func reloadTable()
    
}

class HomePresenter {
    
    /// time table of the student
    var timeTable: Timetable?
    /// system service
    let systemService: SystemDerived
    /// api reuqest service
    let apiRequest: APIRequestType
    /// Display delegate
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
    
    /// Get items for section
    /// - Parameter section: HomeSection
    func getItems(for section: HomeSection) -> [HomeCellModel] {
        guard let timeTable = timeTable else {
            return []
        }
        switch section {
        case .busSchedule:
            return timeTable.stops
                .filter {
                    systemService.now <= $0.predictedArrivalDate.dateInISOformat()
            }
            .map {
                return BusCellModel (
                    departure: $0.departure,
                    arrival: $0.arrival,
                    predictedDateTime: $0.predictedArrivalDate.dateInISOformat()
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
                    systemService.now <= $0.startTime.dateInISOformat()
                        && Calendar.current.isDate(systemService.now, inSameDayAs:$0.startTime.dateInISOformat())
                }
                .map {
                return CourseCellModel(
                    startTime: $0.startTime.dateInISOformat(),
                    endTime: $0.endTime.dateInISOformat(),
                    course: $0.course + " \($0.scheduleClass)",
                    tutor: $0.lecturer ,
                    location: $0.room  + ", \($0.campus)"
                )
            }.first(elementCount: 3)
        }
    }
    
    
    /// Get number of sections
    func getNumberOfSections() -> Int {
        return HomeSection.allCases.count
    }
    
    
    /// Get number of rows in a section
    /// - Parameter type: HomeSection
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
                systemService.now <= $0.predictedArrivalDate.dateInISOformat()
            }.count > 0 ? 1 : 0
        }
    }
}

private extension String {
    
    static let unknownError = NSLocalizedString("Something went wrong", comment: "Unknown error message")
    static let hey = NSLocalizedString("Hey, ", comment: "Student welcome")
    
    /// Init date in ISO format
    func dateInISOformat() -> Date {
        return Date(self, dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
    }
}

private extension Array {
    
    /// Get numbers of item in an array
    /// - Parameter elementCount: integer
    func first(elementCount: Int) -> Array {
          let min = Swift.min(elementCount, count)
          return Array(self[0..<min])
    }
}
