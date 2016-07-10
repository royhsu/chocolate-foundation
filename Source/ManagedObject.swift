//
//  ManagedObject.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

public class ManagedObject: NSManagedObject {
    
    public enum ValueType {
        case string
    }
    
    public typealias Schema = [String: ValueType]
    
    
    // MARK: Init
    
    public class func entity(forEntityName entityName: String, from schema: Schema, in model: NSManagedObjectModel) -> NSEntityDescription {
        
        let entity = NSEntityDescription()
        
        entity.name = entityName
        entity.managedObjectClassName = entityName
        
        for (key, valueType) in schema {
            
            switch valueType {
            case .string:
                
                let property = NSAttributeDescription()
                property.name = key
                property.attributeType = .stringAttributeType
                property.isOptional = true
                
                entity.properties.append(property)
            
            }
            
        }
        
        model.entities.append(entity)
        
        return entity
        
    }
    
}
