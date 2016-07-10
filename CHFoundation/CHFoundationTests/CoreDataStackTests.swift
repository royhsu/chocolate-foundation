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
        
        let stack = try? CoreDataStack(
            name: "Test",
            model: NSManagedObjectModel(),
            context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
            options: nil,
            storeType: .directory(.document(mask: .userDomainMask))
        )
        
        XCTAssertNotNil(stack, "Cannot initialize stack.")
        
        XCTAssertNotNil(stack!.storeURL, "Should have store url.")
        
    }
    
    func testInitInMemory() {
        
        let stack = try? CoreDataStack(
            name: "Test",
            model: NSManagedObjectModel(),
            context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
            options: nil,
            storeType: .memory
        )
        
        XCTAssertNotNil(stack, "Cannot initialize stack.")
        
        XCTAssertNil(stack!.storeURL, "Should not have store url.")
        
    }
    
}
