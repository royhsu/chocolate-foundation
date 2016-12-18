//
//  String+ISO8601.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/12/18.
//  Copyright © 2016年 Tiny World. All rights reserved.
//  Reference: http://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim
//

import Foundation

public extension String {
    
    public var iso8601Date: Date? {
        
        return Date.Formatter.iso8601.date(from: self)
        
    }
    
}
