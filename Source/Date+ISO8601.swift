//
//  Date+ISO8601.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/12/18.
//  Copyright © 2016年 Tiny World. All rights reserved.
//  Reference: http://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim
//

import Foundation

public extension Date {
    
    public struct Formatter {
        
        public static let iso8601: DateFormatter = {
            
            let formatter = DateFormatter()
            
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            
            return formatter
            
        }()
        
    }
    
    public var iso8601String: String {
        
        return Formatter.iso8601.string(from: self)
        
    }
    
}
