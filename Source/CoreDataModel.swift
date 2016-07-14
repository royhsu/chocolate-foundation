//
//  ManagedObject.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

public final class CoreDataModel: NSManagedObjectModel {
    
    
    // MARK: Entity
    
    /**
     This function will validate the input entity properties with schema fields that do match before adding it into model.
     
     - Author: Roy Hsu.
     
     - Parameter entity: The entity to add with.
     
     - Parameter schemaType: The schema type of adding entity.
     
     - Important: This function will prevent adding duplicated entity automatically.
    */
    
    public func add(entity: NSEntityDescription, of schemaType: CoreDataSchema.Type) {
        
        if validate(schemaType: schemaType) { return }
        
        entities.append(entity)
        
    }
    
}


// MARK: NSManagedObjectModel

public extension NSManagedObjectModel {
    
    /**
     The validation checks whether the schema had been added and all fields must match the required fileds you define in schema template.
     
     - Author: Roy Hsu
     
     - Parameter schemaType: A schema type.
     
     - Returns: The validation result.
     */
    
    public func validate(schemaType: CoreDataSchema.Type) -> Bool {
        
        guard let entity = entitiesByName[schemaType.identifier]
            else { return false }
        
        let templateSet = Set(schemaType.template.map({ $0.key }))
        let objectSet = Set(entity.propertiesByName.map({ $0.key }))
        
        return templateSet.subtracting(objectSet).isEmpty
        
    }
    
}
