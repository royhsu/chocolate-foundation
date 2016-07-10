//
//  ManagedObject.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

public final class CoreDataModel: NSManagedObjectModel {
    
    
    // MARK: Schema
    
    public func add(schema: CoreDataSchema) {
        
        let schemaType = schema.dynamicType
        
        if contains(schemaType: schemaType) { return }
        
        let entityName = schemaType.identifier
        let entity = NSEntityDescription()

        entity.name = entityName
        entity.managedObjectClassName = entityName

        for (key, valueType) in schema.template {

            switch valueType {
            case .string:

                let property = NSAttributeDescription()
                property.name = key
                property.attributeType = .stringAttributeType
                property.isOptional = true

                entity.properties.append(property)
            
            }
            
        }
        
        entities.append(entity)
        
    }
    
}
