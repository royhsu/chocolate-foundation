//
//  CoreDataStack.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/10.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import CoreData

struct CoreDataStack {
    
    let context: NSManagedObjectContext
    let storeCoordinator: NSPersistentStoreCoordinator
    let storeURL: NSURL
    
    init(name: String, model: NSManagedObjectModel, context: NSManagedObjectContext, options: [NSObject: AnyObject]? = nil, at directory: Directory) throws {
        
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        context.persistentStoreCoordinator = storeCoordinator
        
        do {
            
            let storePath = try directory.path
                .appendingPathComponent(name)
                .appendingPathExtension("sqlite")
            
            let storeURL = URL(string: storePath)!
            
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
            
            self.context = context
            self.storeCoordinator = storeCoordinator
            self.storeURL = storeURL
        
        }
        catch { throw error }
        
    }
    
}
