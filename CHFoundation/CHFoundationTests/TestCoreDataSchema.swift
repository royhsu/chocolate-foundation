//
//  TestCoreDataSchema.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CHFoundation

class TestCoreDataSchema: CoreDataSchema {
    
    static var template: Template = [
        "firstName": .string,
        "lastName": .string
    ]

}
