//
//  TestPresenter.swift
//  CodingChallengeTests
//
//  Created by iOS Developer on 3/16/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import XCTest
@testable import CodingChallenge


class MockTestDisplay: HomeDisplay {
    var asyncExpectation: XCTestExpectation?
    func set(name: String, date: String) {
        print(name)
    }
    
    func errorDisplay(message: String) {
        
    }
    
    func reloadTable() {
        
    }
}

class TestPresenter: XCTestCase {

    var presenter: HomePresenter!
    var systemService: SystemDerived!
    
    override func setUp() {
        let mockTramSession = MockScheduleSession()
        let apiService = APIRequest(session: mockTramSession)
        systemService = MockSystem()
        let display = MockTestDisplay()
        presenter = HomePresenter(systemService: systemService, apiService: apiService)
        presenter.display = display
    }
    
    func testLoadData() {
        XCTAssertEqual(presenter.timeTable?.week, 8)
        XCTAssertEqual(presenter.timeTable?.student.id, "305491")
        XCTAssertEqual(presenter.timeTable?.student.name, "Kier")
        XCTAssertEqual(presenter.timeTable?.schedules[0].startTime, "2020-03-13T10:00:00")
        XCTAssertEqual(presenter.timeTable?.schedules[0].course, "FIT1031")
        XCTAssertEqual(presenter.timeTable?.parkings[0].name, "Clayton live feed")
        XCTAssertEqual(presenter.timeTable?.stops[0].departure, "Clayton")
        XCTAssertEqual(presenter.timeTable?.stops[0].arrival, "Caufield")
    }
    
    func testGetItemsAtSection() {
        // Only get 3 last items
        XCTAssertEqual(presenter.getItems(for: .schedule).count, 3)
        XCTAssertEqual(presenter.getItems(for: .parking).count, 2)
        // Get the bus schedule based on time
        XCTAssertEqual(presenter.getItems(for: .busSchedule).count, 1)
    }
    
    func testGetNumberOfSections() {
        XCTAssertEqual(presenter.getNumberOfSections(), 3)
    }
    
    func testGetNumberOfRows() {
        XCTAssertEqual(presenter.getNumberOfRows(for: .schedule), 1)
        XCTAssertEqual(presenter.getNumberOfRows(for: .parking), 1)
        XCTAssertEqual(presenter.getNumberOfRows(for: .busSchedule), 1)
    }


}
