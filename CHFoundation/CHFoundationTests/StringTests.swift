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
    
}
