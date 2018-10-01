//
//  NSPersistentStoreCoordinator+Extension.swift
//  Myrrh
//
//  Created by kai zhou on 08/01/2018.
//  Copyright © 2018 hereigns. All rights reserved.
//

import Foundation
import CoreData

extension NSPersistentStoreCoordinator {
    // TODO(swift3) Migrate thise to NSPersistentContainer
    public static func destroyStore(at url: URL) {
        do {
            let psc = self.init(managedObjectModel: NSManagedObjectModel())
            try psc.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
        } catch let e {
            print("failed to destroy persistent store at \(url)", e)
        }
    }
    
    // TODO(swift3) Migrate thise to NSPersistentContainer
    public static func replaceStore(at targetURL: URL, withStoreAt sourceURL: URL) throws {
        let psc = self.init(managedObjectModel: NSManagedObjectModel())
        try psc.replacePersistentStore(at: targetURL, destinationOptions: nil, withPersistentStoreFrom: sourceURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
    }
}
