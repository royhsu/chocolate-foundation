//
//  CoreDataSchema.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

public class CoreDataSchema {
    
    public enum ValueType {
        case string
    }
    
    public typealias Template = [String: ValueType]
    
    
    // MARK: Property
    
    public let template: Template
    
    
    // MARK: Init
    
    public init(template: Template) { self.template = template }
    
    
    // MARK: NSManagedObject
    
    enum CoreDataSchemaError: ErrorProtocol {
        case noModelInContext
        case noEntityDescriptionInModel
    }
    
    public class func insertObject(into context: NSManagedObjectContext) throws -> NSManagedObject {
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel
            else { throw CoreDataSchemaError.noModelInContext }
        
        if !model.contains(schemaType: self) { throw CoreDataSchemaError.noEntityDescriptionInModel }
        
        return NSEntityDescription.insertNewObject(forEntityName: identifier, into: context)
        
    }
    
    
    // MARK: NSFetchRequest
    
    public class var fetchRequest: NSFetchRequest<NSManagedObject> {
        
        return NSFetchRequest<NSManagedObject>(entityName: identifier)
        
    }
    
}


// MARK: Identifiable

extension CoreDataSchema: Identifiable {
    
    public class var identifier: String { return String(self.dynamicType) }
    
}


// MARK: NSManagedObjectModel

public extension NSManagedObjectModel {
    
    public func contains(schemaType: CoreDataSchema.Type) -> Bool {
        
        return entitiesByName.contains { $0.key == schemaType.identifier }
        
    }
    
}
