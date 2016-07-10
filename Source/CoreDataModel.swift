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
        
        if validate(schemaType: schemaType) { return }
        
        let entityName = schemaType.identifier
        let entity = NSEntityDescription()

        entity.name = entityName
        entity.managedObjectClassName = entityName

        for (key, valueType) in schema.dynamicType.template {

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


// MARK: NSManagedObjectModel

public extension NSManagedObjectModel {
    
    public func validate(schemaType: CoreDataSchema.Type) -> Bool {
        
        guard let entity = entitiesByName[schemaType.identifier]
            else { return false }
        
        let templateSet = Set(schemaType.template.map({ $0.key }))
        let objectSet = Set(entity.propertiesByName.map({ $0.key }))
        
        return templateSet.elementsEqual(objectSet)
        
    }
    
}
