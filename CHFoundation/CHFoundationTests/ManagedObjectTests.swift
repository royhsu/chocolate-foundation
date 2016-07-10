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
    
    func testInit() {
        
        let model = NSManagedObjectModel()
        let schema: [String: ManagedObject.ValueType] = [
            "firstName": .string,
            "lastName": .string
        ]
        let entity = ManagedObject.entity(forEntityName: "Person", from: schema, in: model)
        
        XCTAssertNotNil(entity, "Cannot initialize entity from json.")
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistentStoreCoordinator.addPersistentStore(
            ofType: NSInMemoryStoreType,
            configurationName: nil,
            at: nil,
            options: nil
        )
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        let person1 = NSEntityDescription.insertNewObject(forEntityName: "Person", into: managedObjectContext)
        
        person1.setValue("Roy", forKey: "firstName")
        person1.setValue("Hsu", forKey: "lastName")
        
        try! managedObjectContext.save()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.sortDescriptors = [
            SortDescriptor(key: "firstName", ascending: true)
        ]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        try! controller.performFetch()
        
        let object = controller.object(at: IndexPath(row: 0, section: 0))
        
        let firstName = object.value(forKey: "firstName") as? String
        
        XCTAssertEqual(firstName, "Roy", "The first name doesn't match.")
        
        let lastName = object.value(forKey: "lastName") as? String
        
        XCTAssertEqual(lastName, "Hsu", "The last name doesn't match.")
        
    }
    
}
