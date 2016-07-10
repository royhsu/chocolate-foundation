//
//  CoreDataStack.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

public struct CoreDataStack {
    
    let context: NSManagedObjectContext
    let storeCoordinator: NSPersistentStoreCoordinator
    let storeURL: NSURL?
    
    public enum StoreType {
        case directory(Directory)
        case memory
    }
    
    init(name: String, model: NSManagedObjectModel, context: NSManagedObjectContext, options: [NSObject: AnyObject]? = nil, storeType: StoreType) throws {
        
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        context.persistentStoreCoordinator = storeCoordinator
        
        do {
            
            switch storeType {
            case .directory(let directory):
                
                let storeURL = try directory.url
                    .appendingPathComponent(name)
                    .appendingPathExtension("sqlite")
                
                try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
                
                self.context = context
                self.storeCoordinator = storeCoordinator
                self.storeURL = storeURL
                
            case .memory:
                
                try storeCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: options)
                
                self.context = context
                self.storeCoordinator = storeCoordinator
                self.storeURL = nil
            }
            
        }
        catch { throw error }
        
    }
    
}
