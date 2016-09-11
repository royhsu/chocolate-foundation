//
//  CoreDataSchema.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

public enum ValueType {
    case string
    case date
}

public typealias Template = [String: ValueType]

public enum CoreDataSchemaError: Error {
    case noModelInContext
    case invalidSchemaInModel
    case jsonKeysNotMatchingSchema
    case valueTypeNotMatching(forKey: String)
}


// MARK: CoreDataSchema

public protocol CoreDataSchema: class, Identifiable {
    
    
    // MARK: Property
    
    /// Please define required fileds in this template.
    static var template: Template { get }
    
}


// MARK: Identifiable

public extension CoreDataSchema {
    
    /// Overriding this property for custom identifier of schema. Default is its type name.
    static var identifier: String { return String(describing: self) }
    
}


// MARK: NSManagedObject

public extension CoreDataSchema {
    
    /**
     This method will generate a managed object for you by inserting into managed object context.
     
     - Author: Roy Hsu.
     
     - Parameter context: The destination managed context.
     
     - Returns: The inserted managed object.
    */
    
    func insertObject(into context: NSManagedObjectContext) throws -> NSManagedObject {
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel
            else {
                
                throw CoreDataSchemaError.noModelInContext
                
        }
        
        let schemaType = type(of: self)
        
        if !model.validate(schemaType: schemaType) {
            
            throw CoreDataSchemaError.invalidSchemaInModel
            
        }
        
        return NSEntityDescription.insertNewObject(forEntityName: Self.identifier, into: context)
        
    }
    
    /**
     This method will generate a managed object with json object for you by inserting into managed object context.
     
     - Author: Roy Hsu.
     
     - Parameter json: A json object in dictionary format.
     
     - Parameter context: The destination managed context.
     
     - Returns: The inserted managed object.
    */
    
    func insertObject(with json: [String: AnyObject], into context: NSManagedObjectContext) throws -> NSManagedObject {
        
        let template = Self.template
        let templateSet = Set(template.map({ $0.key }))
        let jsonSet = Set(json.map({ $0.key }))
        
        if !templateSet.subtracting(jsonSet).isEmpty {
            
            throw CoreDataSchemaError.jsonKeysNotMatchingSchema
            
        }
        
        do {
            
            let object = try insertObject(into: context)
            
            for (key, value) in json {
                
                switch template[key]! {
                case .string:
                    
                    if !(value is String) {
                        
                        throw CoreDataSchemaError.valueTypeNotMatching(forKey: key)
                        
                    }
                    
                case .date:
                    
                    if !(value is Date) {
                        
                        throw CoreDataSchemaError.valueTypeNotMatching(forKey: key)
                        
                    }
                }
                
                object.setValue(value, forKey: key)
                
            }
            
            return object
            
        }
        catch { throw error }
        
    }
    
}


// MARK: NSEntityDescription

public extension CoreDataSchema {
    
    /// An entity based on schema template.
    var entity: NSEntityDescription {
        
        let schemaType = type(of: self)
        let entityName = schemaType.identifier
        let entity = NSEntityDescription()
        
        entity.name = entityName
        
        for (key, valueType) in Self.template {
            
            switch valueType {
            case .string:
                
                let property = NSAttributeDescription()
                property.name = key
                property.attributeType = .stringAttributeType
                property.isOptional = true
                
                entity.properties.append(property)
                
            case .date:
                
                let property = NSAttributeDescription()
                property.name = key
                property.attributeType = .dateAttributeType
                property.isOptional = true
                
                entity.properties.append(property)
            }
            
        }
        
        return entity
        
    }
    
}


// MARK: NSFetchRequest

extension CoreDataSchema {
    
    /// A fetch request for schema entity.
    public static var fetchRequest: NSFetchRequest<NSManagedObject> {
        
        return NSFetchRequest<NSManagedObject>(entityName: identifier)
        
    }
    
}
