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
    
    func testAppendingPathComponent() {
        
        let appendingPath = "test"
        
        let filePath = "examples/example"
        let finalFilePath = filePath.appendingPathComponent(appendingPath)
        let expectedPath = filePath + "/\(appendingPath)"
        
        XCTAssertEqual(finalFilePath, expectedPath, "The result doesn't match.")
        
        let urlString = "http://example.com"
        let finalURLString = urlString.appendingPathComponent(appendingPath)
        let expectedURLString = urlString + "/\(appendingPath)"
        
        XCTAssertNotEqual(finalURLString, expectedURLString, "The result doesn't match.")
        
    }
    
    func testAppendingPathExtension() {
        
        let appendingExtension = "txt"
        
        let filePath = "example"
        
        do {
            
            let finalFilePath = try filePath.appendingPathExtension(appendingExtension)
            let expectedPath = filePath + ".\(appendingExtension)"
        
            XCTAssertEqual(finalFilePath, expectedPath, "The result doesn't match.")
            
        }
        catch {
            
            XCTAssertNil(error, "Should not throw a error.")
            
        }
        
        let urlString = "http://example"
        
        do {
        
            let finalURLString = try urlString.appendingPathExtension(appendingExtension)
            let expectedURLString = urlString + "/\(appendingExtension)"
            
            XCTAssertNotEqual(finalURLString, expectedURLString, "The result doesn't match.")
            
        }
        catch {
            
            XCTAssertNil(error, "Should not throw a error.")
            
        }
        
    }
    
    func testConvertingJSONString() {
        
        let jsonObject: [NSObject: AnyObject] = [
            "name": "Allen",
            "age": 20
        ]
        
        do {
            
            let jsonString = try String(jsonObject: jsonObject)
            
            let expectedJSONString = "{\"age\":20,\"name\":\"Allen\"}"
            
            XCTAssertEqual(jsonString, expectedJSONString)
            
        }
        catch {
        
            XCTAssertNil(error, "Should not throw a error.")
        
        }
        
    }
    
    func testConvertingJSONObject() {
        
        let jsonString = "{\"age\":20,\"name\":\"Allen\"}"
        
        do {
            
            let jsonObject = try jsonString.jsonObject() as? [NSObject: AnyObject]
            
            XCTAssertNotNil(jsonObject, "The converted result should be a dictionary.")
            
            let expectedJSONObject: [NSObject: AnyObject] = [
                "name": "Allen",
                "age": 20
            ]
            
            let name = jsonObject!["name"] as? Int
            let expectedName = expectedJSONObject["name"] as? Int
            
            XCTAssertEqual(name, expectedName, "The converted key value pairs doesn't match.")
            
            let age = jsonObject!["age"] as? Int
            let expectedAge = expectedJSONObject["age"] as? Int
                
            XCTAssertEqual(age, expectedAge, "The converted key value pairs doesn't match.")
            
        }
        catch {
            
            XCTAssertNil(error, "Should not throw a error.")
            
        }
        
    }
    
}
