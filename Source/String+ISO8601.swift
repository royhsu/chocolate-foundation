//
//  String+ISO8601.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/12/18.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import Foundation

public extension String {
    
    public var iso8601Date: Date? {
        
        return Date.Formatter.iso8601.date(from: self)
        
    }
    
}
