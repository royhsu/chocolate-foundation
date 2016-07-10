//
//  CoreDataTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import CoreData
import XCTest

class CoreDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithJSON() {
        
        let model = NSManagedObjectModel()
        let json: [NSObject: AnyObject] = [:]
        let entity = ManagedObject.entity(forEntityName: "Person", from: json, in: model)
        
        XCTAssertNotNil(entity, "Cannot initialize entity from json.")
        
    }
    
}
