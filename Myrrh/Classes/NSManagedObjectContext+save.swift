//
//  NSManagedObjectContext+Sugar.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 01/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObjectContext{
//    func insertObject<A: NSManagedObject>() -> A where A: Managed {
//        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Wrong object type") }
//        return obj
//    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    func save(complete:(()->()), fails:((_ error:Error)->())? = nil){
        do {
            try save()
            complete()
        } catch {
            rollback()
            fails?(error)
        }
    }
    
    func performChanges(block: (() -> ())? = nil) {
        perform {
            block?()
            _ = self.saveOrRollback()
        }
    }
    
    func performChangesAndWait(_ block: (() -> ())? = nil) {
        performAndWait {
            block?()
            _ = self.saveOrRollback()
        }
    }
    

}
