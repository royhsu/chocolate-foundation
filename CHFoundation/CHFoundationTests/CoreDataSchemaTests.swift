//
//  CoreDataSchemaTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import CoreData
import XCTest

class CoreDataSchemaTests: XCTestCase {
    
    var schema: TestCoreDataSchema?
    var model: CoreDataModel?
    var stack: CoreDataStack?
    
    override func setUp() {
        super.setUp()
        
        schema = TestCoreDataSchema()
        
        model = CoreDataModel()
        model!.add(entity: schema!.entity, of: TestCoreDataSchema.self)
        
        stack = try! CoreDataStack(
            name: "Test",
            model: model!,
            options: nil,
            storeType: .memory
        )
        
    }
    
    override func tearDown() {
        
        model = nil
        stack = nil
        schema = nil
        
        super.tearDown()
    }

    func testInsertObject() {
        
        let object = try? schema!.insertObject(into: stack!.writerContext)
        
        XCTAssertNotNil(object, "Cannot insert a object into context.")
        
    }
    
    func testInsertObjectWithJSON() {
        
        let object = try? schema!.insertObject(
            with: [
                "firstName": "Chocolate",
                "lastName": "Awesome"
            ],
            into: stack!.writerContext
        )
        
        XCTAssertNotNil(object, "Cannot insert a object with json into context.")
        
    }
    
}
