//
//  SystemService.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/14/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation


/// The system service that will be used in the project
protocol SystemDerived {
    /// The current date time
    var now: Date { get }
}

struct SystemService: SystemDerived {
    
    var now: Date {
        // Mocking the date 
        return Date("2020-03-13T09:00:00", dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
    }
}
