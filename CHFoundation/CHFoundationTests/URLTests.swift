//
//  URLTests.swift
//  CHFoundationTests
//
//  Created by 許郁棋 on 2016/6/27.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import XCTest
@testable import CHFoundation

class URLTests: XCTestCase {
    
    func testFileURLWithSpecificFileAndExtension() {
        
        let filename = "test"
        let fileExtension = "txt"
        let document = Directory.document(mask: .userDomainMask)
        
        do {
            
            let fileURL = try URL(filename: filename, withExtension: fileExtension, in: document)
            
            let expectedFilePath = document.path + "/\(filename).\(fileExtension)"
            
            XCTAssertNotNil(fileURL.path, "The result path should no be nil.")
        
            XCTAssertEqual(fileURL.path!, expectedFilePath, "The result doesn't match.")
            
        }
        catch {
            
            XCTAssertNil(error, "Should not throw a error.")
            
        }
        
    }
    
}
