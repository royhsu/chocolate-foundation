//
//  ManagedObject.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

public class ManagedObject: NSManagedObject {
    
    public class func entity(forEntityName entityName: String, from json: [NSObject: AnyObject], in model: NSManagedObjectModel) -> NSEntityDescription {
        
        let entity = NSEntityDescription()
        
        entity.name = entityName
        entity.managedObjectClassName = entityName
        
        model.entities.append(entity)
        
        return entity
        
    }
    
}
