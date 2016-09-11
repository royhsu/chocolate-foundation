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
    
    
    // MARK: File
    
    func testGetFileURLWithSpecifiedFilenameAndExtension() {
        
        let filename = "test"
        let fileExtension = "txt"
        let document = Directory.document(domainMask: .userDomainMask)
        
        let fileURL = URL.fileURL(filename: filename, withExtension: fileExtension, in: document)
        
        let expectedFilePath = document.path + "/\(filename).\(fileExtension)"
    
        XCTAssertEqual(fileURL.path, expectedFilePath, "The file urls doesn't match.")
          
    }
    
}
