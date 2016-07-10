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
        
        let name = "Test"
        let storeURL = try! Directory.document(mask: .userDomainMask).url
            .appendingPathComponent(name)
            .appendingPathExtension("sqlite")
        
        let stack = try? CoreDataStack(
            name: name,
            model: NSManagedObjectModel(),
            context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
            options: nil,
            storeType: .local(storeURL: storeURL)
        )
        
        XCTAssertNotNil(stack, "Cannot initialize stack.")
        
    }
    
    func testInitInMemory() {
        
        let name = "Test"
        let stack = try? CoreDataStack(
            name: name,
            model: NSManagedObjectModel(),
            context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
            options: nil,
            storeType: .memory
        )
        
        XCTAssertNotNil(stack, "Cannot initialize stack.")
        
    }
    
}
