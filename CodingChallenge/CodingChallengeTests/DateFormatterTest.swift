//
//  DateFormatterTest.swift
//  CodingChallengeTests
//
//  Created by iOS Developer on 3/16/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit
import Foundation
import XCTest
@testable import CodingChallenge

class DateFormatterTest: XCTestCase {
    
    var currentTestingTime = MockSystem().now

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    
    func testTimeIn12HourFormat() {
        let expectedTime = currentTestingTime.timeIn12HourFormat()
        XCTAssertEqual(expectedTime, "08:00 AM")
    }
    
    func testTimeDifferenceWithHoursMinutes() {
        let sinceTime = Date("2020-03-13T10:10:00", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
        let expectedTime = currentTestingTime.timeDifference(since: sinceTime)
        XCTAssertEqual(expectedTime, "2 hours 10 mins")
    }
    
    func testTimeDifferenceWithMinutes() {
        let sinceTime = Date("2020-03-13T08:10:00", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
        let expectedTime = currentTestingTime.timeDifference(since: sinceTime)
        XCTAssertEqual(expectedTime, "10 mins")
    }
        
    func testTimeDifferenceWithNow() {
        let sinceTime = Date("2020-03-13T08:00:00", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
        let expectedTime = currentTestingTime.timeDifference(since: sinceTime)
        XCTAssertEqual(expectedTime, "now")
    }
    

}
