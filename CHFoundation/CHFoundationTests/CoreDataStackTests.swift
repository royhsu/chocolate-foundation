//
//  CoreDataStackTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import CoreData
import XCTest

class CoreDataStackTests: XCTestCase {
    
    var stack: CoreDataStack?
    
    override func setUp() {
        super.setUp()
        
        stack = CoreDataStack(model: NSManagedObjectModel())
        
    }
    
    override func tearDown() {
        
        stack = nil
        
        super.tearDown()
    }
    
    
    func testLoadStoreInLocal() {
        
        let expectation = self.expectation(description: "Load store in local.")
        
        let document = Directory.document(domainMask: .userDomainMask)
        let storeURL = URL.fileURL(filename: "Test", withExtension: "sqlite", in: document)
        
        let _ =
        stack!
            .loadStore(type: .local(storeURL))
            .then { stack in
                
                /// Test for error code 134080: Can't add the same store twice.
                return stack.loadStore(type: .local(storeURL))
            
            }
            .catch { error in
                
                XCTAssertNil(error, "Can't load store in local. \(error.localizedDescription)")
                
            }
            .always { expectation.fulfill() }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
    }
    
    func testInitInMemory() {
        
        let expectation = self.expectation(description: "Load store in memory.")
        
        let _ =
        stack!
            .loadStore(type: .memory)
            .catch { error in
                
                XCTAssertNil(error, "Can't load store in memory. \(error.localizedDescription)")
                
            }
            .always { expectation.fulfill() }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
    }
    
}
