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
    
    func testInitInDirectoy() {
        
        let document = Directory.document(domainMask: .userDomainMask)
        let storeURL = URL.fileURL(filename: "Test", withExtension: "sqlite", in: document)
        
        let stack = try? CoreDataStack(
            model: NSManagedObjectModel(),
            options: nil,
            storeType: .local(storeURL: storeURL)
        )
        
        XCTAssertNotNil(stack, "Cannot initialize stack.")
        
    }
    
    func testInitInMemory() {
        
        let stack = try? CoreDataStack(
            model: NSManagedObjectModel(),
            options: nil,
            storeType: .memory
        )
        
        XCTAssertNotNil(stack, "Cannot initialize stack.")
        
    }
    
}
