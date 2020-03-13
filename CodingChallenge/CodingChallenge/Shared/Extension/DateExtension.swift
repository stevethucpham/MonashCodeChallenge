//
//  DateExtension.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

// MARK: Date Extension
extension Date {
    
    init(_ dateTimeString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateTimeString)!
        self.init(timeInterval:0, since:date)
    }
    
    /// Convert date to string
       ///
       /// - Parameter format: DateFormatter
       /// - Returns: String from date
       func toString(format: DateFormatter)-> String {
           return format.string(from:self)
       }
    
    func convertToString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return toString(format: dateFormatter)
    }
    
    /// This method is used to display the hour in 12 hour format
    func timeIn12HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    /// This method is used to calculate the difference between two time
    /// - Parameter fromTime: the time to compare with
    func timeDifference(since fromTime: Date) -> String {
        let interval = abs(self.timeIntervalSince(fromTime))
        let hours = Int(interval / 3600)
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        if hours != 0 {
            return "\(hours.of("hour")) \(minutes.of("min"))"
        } else if minutes != 0 {
            return "\(minutes.of("min"))"
        } else {
            return "now"
        }
    }
}


// MARK: Integer extension
extension Int {
    
    /// This method is used to display the noun as plural or singular
    /// - Parameter name: The noun name. For example, student
    func of(_ name: String) -> String {
        guard self != 1 else { return "\(self) \(name)" }
        return "\(self) \(name)s"
    }
}

