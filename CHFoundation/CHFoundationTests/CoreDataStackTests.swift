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
    
    func testInit() {
        
        let stack = try? CoreDataStack(
            name: "Test",
            model: NSManagedObjectModel(),
            context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
            options: nil,
            at: .document(mask: .userDomainMask)
        )
        
        XCTAssertNotNil(stack, "Cannot initialize stack.")
        
    }
    
}
