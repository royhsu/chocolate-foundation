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
}

public typealias Template = [String: ValueType]

public enum CoreDataSchemaError: ErrorProtocol {
    case noModelInContext
    case invalidSchemaInModel
    case jsonKeysNotMatchingSchema
    case valueTypeNotMatching(forKey: String)
}


// MARK: CoreDataSchema

public protocol CoreDataSchema: class, Identifiable {
    
    
    // MARK: Property

    static var template: Template { get }
    
}


// MARK: Identifiable

extension CoreDataSchema {
    
    public static var identifier: String { return String(self.dynamicType) }
    
}


// MARK: NSManagedObject

extension CoreDataSchema {

    public func insertObject(into context: NSManagedObjectContext) throws -> NSManagedObject {
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel
            else { throw CoreDataSchemaError.noModelInContext }
        
        if !model.validate(schemaType: self.dynamicType) {
            
            throw CoreDataSchemaError.invalidSchemaInModel
        
        }
        
        return NSEntityDescription.insertNewObject(forEntityName: self.dynamicType.identifier, into: context)
        
    }
    
    public func insertObject(with json: [String: AnyObject], into context: NSManagedObjectContext) throws -> NSManagedObject {
        
        let template = self.dynamicType.template
        let templateSet = Set(template.map({ $0.key }))
        let jsonSet = Set(json.map({ $0.key }))
        
        if !templateSet.elementsEqual(jsonSet) {
            
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
                    
                    object.setValue(value, forKey: key)
                    
                }
                
            }
            
            return object
            
        }
        catch { throw error }
        
    }
    
}


// MARK: NSFetchRequest

extension CoreDataSchema {
    
    public static var fetchRequest: NSFetchRequest<NSManagedObject> {
        
        return NSFetchRequest<NSManagedObject>(entityName: identifier)
        
    }
    
}
