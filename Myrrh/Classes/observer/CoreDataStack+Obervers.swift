//
//  MyrrhObervers.swift
//  Myrrh
//
//  Created by Kevin Zhou on 19/10/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataStack{
    
    func addObservers(){
        //every save()
        NotificationCenter.default.addObserver(self, selector: #selector(contextWillSaveHandler(note:)), name: .NSManagedObjectContextWillSave, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSaveHandler(note:)), name: .NSManagedObjectContextDidSave, object: nil)

        //every processPendingChanges()
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChangeHandler(note:)), name: .NSManagedObjectContextObjectsDidChange, object: nil)

        
    }
    
    @objc func contextWillSaveHandler(note:Notification) {
        LogInfo(note)
        
        
    }
    
    @objc func contextDidSaveHandler(note:Notification) {
        LogInfo(note)
//        note.name.rawValue == "NSManagingContextDidSaveChangesNotification"
        LogInfo("InsertedObjects:\(String(describing: note.userInfo?[NSInsertedObjectsKey]))")
        LogInfo("UpdatedObjects:\(note.userInfo?[NSUpdatedObjectsKey] ?? "")")
        LogInfo("DeletedObjects:\(note.userInfo?[NSDeletedObjectsKey] ?? "")")
        LogInfo("RefreshedObjects:\(note.userInfo?[NSRefreshedObjectsKey] ?? "")")
        
        LogInfo("NSManagedObjectContextQueryGenerationKey:\(note.userInfo?[NSManagedObjectContextQueryGenerationKey] ?? "")")
        
    }
    

    @objc func contextObjectsDidChangeHandler(note:Notification) {

        LogInfo(note)
//        note.name.rawValue == "NSObjectsChangedInManagingContextNotification"
        
        LogInfo("InsertedObjects:\(String(describing: note.userInfo?[NSInsertedObjectsKey]))")
        LogInfo("UpdatedObjects:\(note.userInfo?[NSUpdatedObjectsKey] ?? "")")
        
        if let updatedObjectsSet = note.userInfo?[NSUpdatedObjectsKey] as? NSSet{
            for obj in updatedObjectsSet.allObjects{
                LogInfo((obj as! NSManagedObject).hasPersistentChangedValues) //if different return true
                LogInfo((obj as! NSManagedObject).changedValuesForCurrentEvent()) //KEY:attribute name, VALUE: old value
                LogInfo((obj as! NSManagedObject).changedValues()) //KEY:attribute name, VALUE: change date
                LogInfo((obj as! NSManagedObject).committedValues(forKeys: nil)) //all key and value of old value
            }
        }
        
        
        
//        po ((note.userInfo[NSUpdatedObjectsKey] as? NSSet)?.allObjects[0] as? NSManagedObject)?.hasChanges
        
        LogInfo("DeletedObjects:\(note.userInfo?[NSDeletedObjectsKey] ?? "")")
        LogInfo("RefreshedObjects:\(note.userInfo?[NSRefreshedObjectsKey] ?? "")")
        LogInfo("InvalidatedObjects:\(note.userInfo?[NSInvalidatedObjectsKey] ?? "")")
        LogInfo("InvalidatedAllObjects:\(note.userInfo?[NSInvalidatedAllObjectsKey] ?? "")")
        
        LogInfo("userinfo.managedObjectContext:\(note.userInfo?["managedObjectContext"] ?? "")")
        LogInfo("object is NSManagedObjectContext:\(note.object as! NSManagedObjectContext)")
        
        (note.object as! NSManagedObjectContext).hasChanges
        (note.object as! NSManagedObjectContext).insertedObjects
        (note.object as! NSManagedObjectContext).updatedObjects
        (note.object as! NSManagedObjectContext).deletedObjects
        
        
        LogInfo("NSObjectsChangedByMergeChangesKey:\(note.userInfo?["NSObjectsChangedByMergeChangesKey"] ?? "")")
        
    }
}
