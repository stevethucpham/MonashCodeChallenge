//
//  MockURLSession.swift
//  CodingChallengeTests
//
//  Created by iOS Developer on 3/16/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation
@testable import CodingChallenge

struct MockSystem: SystemDerived {
    var now: Date {
         return Date("2020-03-13T08:00:00", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
  override func resume() {
    print("mock resume")
  }
}
// MARK: Mock Schedule Session
class MockScheduleSession: URLSession {
     override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data =  loadData("service.json")
        let response = HTTPURLResponse(url: URL(string: Constants.scheduleURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        completionHandler(data, response, nil)
        return MockURLSessionDataTask()
      }
}


// MARK: Mock Fail Session
class MockFailSession: URLSession {
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let jsonString =  """
{
  
}
"""
        let data = jsonString.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: Constants.scheduleURL)!, statusCode: 500, httpVersion: nil, headerFields: nil)
        completionHandler(data, response, nil)
        
        return MockURLSessionDataTask()
    }
}
