//
//  ManagedObjectTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import CoreData
import XCTest

class ManagedObjectTests: XCTestCase {
    
    func testAddSchema() {
        
        let model = CoreDataModel()
        
        class PersonSchema: CoreDataSchema { }
        
        let schema = PersonSchema(
            template: [
                "firstName": .string,
                "lastName": .string
            ]
        )
        model.add(schema: schema)
        
        let isContaining = model.entitiesByName.contains({ $0.key == PersonSchema.identifier })
        
        XCTAssert(isContaining, "Schema should be added.")
        
        let stack = try! CoreDataStack(
            name: "Test", model: model,
            context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
            options: nil,
            storeType: .memory
        )
        
        let person1 = try? PersonSchema.insertObject(into: stack.context)
        
        XCTAssertNotNil(person1, "Cannot intialize object from schema.")
        
        person1!.setValue("Chocolate", forKey: "firstName")
        person1!.setValue("Awesome", forKey: "lastName")
        
        try! stack.context.save()
        
        let fetchRequest = PersonSchema.fetchRequest
        fetchRequest.sortDescriptors = [
            SortDescriptor(key: "firstName", ascending: true)
        ]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: stack.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        try! controller.performFetch()
        
        let object = controller.object(at: IndexPath(row: 0, section: 0))
        
        let firstName = object.value(forKey: "firstName") as? String
        
        XCTAssertEqual(firstName, "Chocolate", "The first name doesn't match.")
        
        let lastName = object.value(forKey: "lastName") as? String
        
        XCTAssertEqual(lastName, "Awesome", "The last name doesn't match.")
        
    }
    
}
