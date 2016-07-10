//
//  CoreDataModelTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import CoreData
import XCTest

class CoreDataModelTests: XCTestCase {
    
    var model: CoreDataModel?
    var schema: TestCoreDataSchema?
    
    override func setUp() {
        super.setUp()
        
        model = CoreDataModel()
        schema = TestCoreDataSchema()
        
    }
    
    override func tearDown() {
        
        model = nil
        schema = nil
        
        super.tearDown()
    }
    
    func testValidate() {
        
        model!.add(schema: schema!)
        
        XCTAssert(model!.validate(schemaType: TestCoreDataSchema.self), "Validation failed.")
        
    }
    
    func testAddSchema() {
        
        model!.add(schema: schema!)
        
        let isValidSchema = model!.entitiesByName.contains({ $0.key == TestCoreDataSchema.identifier })
        
        XCTAssert(isValidSchema, "Schema should be added.")
        
    }
    
}
