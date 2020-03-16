//
//  TestService.swift
//  CodingChallengeTests
//
//  Created by iOS Developer on 3/16/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import XCTest
@testable import CodingChallenge

class TestService: XCTestCase {
    
    var apiService: APIRequestType!

    override func setUp() {
        let mockSession = MockScheduleSession()
        apiService = APIRequest(session: mockSession)
    }


    func testGetSchedule() {
        
        apiService.getSchedules
            { (result) in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response?.week, 8)
                    XCTAssertEqual(response?.student.id, "305491")
                    XCTAssertEqual(response?.schedules[0].course, "FIT1031")
                    XCTAssertEqual(response?.parkings[0].name, "Clayton live feed")
                    XCTAssertEqual(response?.stops[0].departure, "Clayton")
                    XCTAssertEqual(response?.stops[0].arrival, "Caufield")
                    break
                case .failure(_):
                    XCTFail()
                    break
                }
        }
    }
    
    func testGetProductFailure() {
        let mockFailSession = MockFailSession()
        let failService = APIRequest(session: mockFailSession)
        
        failService.getSchedules
            { (result) in
                switch result {
                case .success(_):
                    XCTFail()
                    break
                case .failure(let error):
                    let isError = error?.localizedDescription.hasPrefix("Something went wrong")
                    XCTAssertTrue(isError ?? false)
                    break
                }
        }
    }
    
}
