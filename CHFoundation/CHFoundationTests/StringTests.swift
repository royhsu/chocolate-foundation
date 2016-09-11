//
//  StringTests.swift
//  CHFoundationTests
//
//  Created by 許郁棋 on 2016/6/27.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import XCTest
@testable import CHFoundation

class StringTests: XCTestCase {
    
    func testConvertingJSONObjectToString() {
        
        let jsonObject: [AnyHashable: Any] = [
            "name": "Allen",
            "age": 20
        ]
        
        do {
            
            let jsonString = try String(jsonObject: jsonObject)
            
            let expectedJSONString = "{\"name\":\"Allen\",\"age\":20}"
            
            XCTAssertEqual(jsonString, expectedJSONString)
            
        }
        catch {
        
            XCTAssertNil(error, "Cannot convert json object to string.")
        
        }
        
    }
    
    func testConvertingStringToJSONObject() {
        
        let jsonString = "{\"age\":20,\"name\":\"Allen\"}"
        
        do {
            
            let jsonObject = try jsonString.jsonObject() as! NSDictionary
            
            let expectedJSONObject: NSDictionary = [
                "name": "Allen",
                "age": 20
            ]
            
            XCTAssertEqual(jsonObject, expectedJSONObject, "The converted key value pairs doesn't match.")
            
        }
        catch {
            
            XCTAssertNil(error, "Should not throw a error.")
            
        }
        
    }
    
}
