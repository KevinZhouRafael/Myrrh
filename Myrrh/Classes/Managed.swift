//
//  DBModel.swift
//  ActiveSQLite
//
//  Created by zhou kai on 05/06/2017.
//  Copyright © 2017 wumingapie@gmail.com. All rights reserved.
//

import Foundation
import CoreData



public protocol Managed:class,NSFetchRequestResult {
    static var entityName: String{get}
}

public extension NSManagedObject{
    func isTemporaryObject() -> Bool {
        return objectID.isTemporaryID
    }

    func isEntityDeleted()-> Bool{
        return isDeleted || managedObjectContext == nil
    }

}


public extension Managed where Self:NSManagedObject{
    public static var entityName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    static var context:NSManagedObjectContext!{
        get{
            return CoreDataStack.shared.mainContext
        }
    }
    
    static var defaultSortDescriptors:[NSSortDescriptor]{
        return []
    }
    
    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
    public static func sortedFetchRequest(with predicate: NSPredicate) -> NSFetchRequest<Self> {
        let request = sortedFetchRequest
        request.predicate = predicate
        return request
    }

    
    
    func nameOfEntity() -> String{
        return type(of: self).entityName
    }
    
    static func createEntity()->Self{
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? Self else{
            fatalError("Wrong object type")
        }
        return obj
    }
    
//    static func create(in context: NSManagedObjectContext)->Self{
//        return context.insertObject()
//    }


    
    
    //MARK: - Deleting Entities
    func deleteEntity() -> Bool{
        
        do{
            
            if let objectInContext = try managedObjectContext?.existingObject(with: objectID){
                
                managedObjectContext?.delete(objectInContext)
                
                LogInfo("Delete one of \(type(of: self).entityName)  success")
                
                
                return objectInContext.isEntityDeleted()
            }else{
                LogInfo("Delete one of \(type(of: self).entityName) failure: object was not exist.")
                return false
            }
            
        } catch {
            LogError("Delete failure: \(error)")
            return false
        }
    }
    
    
    static func deleteAll(predicate:NSPredicate) -> Bool {
        let request = requestAll(predicate: predicate)
        request.returnsObjectsAsFaults = true
        request.includesPropertyValues = false
        let objectsToTruncate = fetchAll(request)
        for objectToTruncate in objectsToTruncate {
            objectToTruncate.deleteEntity()
        }
        return true
    }
    
    static func deleteAll() -> Bool{
        let request = requestAll()
        request.returnsObjectsAsFaults = true
        request.includesPropertyValues = false
        let objectsToTruncate = fetchAll(request)
        for objectToTruncate in objectsToTruncate {
            objectToTruncate.deleteEntity()
        }
        return true
    }

    
    //TODO: Modify
    static func deleteBatch(_ models:[NSManagedObject]) throws{
        do{
            
            for model in models{
                model.managedObjectContext?.delete(model)
            }
            
//            try Self.context.save()
            
            LogInfo("Delete batch rows of \(entityName) success")
            
        }catch{
            LogError("Delete batch rows of \(entityName) failure: \(error)")
            throw error
        }
    }
    

//    static func a(){
//        let batchUpdate = requestAll()
//        batchUpdate.resultType = .updatedObjectIDsResultType
//        guard let result = try! context.execute(batchUpdate) as?
//            NSBatchUpdateResult else { fatalError("Wrong result type") }
//        guard let objectIDs = result.result as? [NSManagedObjectID]
//            else { fatalError("Expected object IDs") }
//        let changes = [NSUpdatedObjectsKey: objectIDs]
//        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes,
//            into: [context])
//    }
    //MARK: - Sorting Entities
    static func ascendingSortDescriptors(attributesToSortBy:[String])->[NSSortDescriptor]{
        return sortDescriptors(ascending: true, attributes: attributesToSortBy)
    }
    
    static func descendingSortDescriptors(attributesToSortBy:[String])->[NSSortDescriptor]{
        return sortDescriptors(ascending: false, attributes: attributesToSortBy)
    }
    
    static func sortDescriptors(ascending:Bool,attributes:[String])->[NSSortDescriptor]{
        var sorts = [NSSortDescriptor]()
        for attributeName in attributes {
            sorts.append(NSSortDescriptor(key: attributeName, ascending: ascending))
        }
        return sorts
    }
    
    static func sortDescriptors(_ sortDic:Dictionary<String,Bool>)->[NSSortDescriptor]{
        var sorts = [NSSortDescriptor]()
        for (key,value) in sortDic {
            sorts.append(NSSortDescriptor(key: key, ascending: value))
        }
        return sorts
    }
    
    //MARK: - Working Across Contexts
    func refresh() throws{
        managedObjectContext?.refresh(self, mergeChanges: true)
    }
    
    //???
    func obtainPermanentObjectID() {
        if objectID.isTemporaryID {
            do{
                try managedObjectContext?.obtainPermanentIDs(for: [self])
            }catch{
                 LogError("ObtainPermanentIDs of \(nameOfEntity()) failure: \(error)")
            }
            
        }
    }
    
    internal static func fetchFirst(_ request:NSFetchRequest<Self>)->Self?{
        do{
            let results = try context.fetch(request)
            LogVerbose("Find first row of \(entityName) success.")
            return results.first
        }catch{
            LogError("Find first row of \(entityName) fails \(error)")
            return nil
        }
    }
    
    internal static func fetchAll(_ request:NSFetchRequest<Self>)->Array<Self>{
        do{
            let results = try context.fetch(request)
            LogInfo("Find rows of \(entityName) success.")
            return results
        }catch{
            LogError("Find rows of \(entityName) fails \(error)")
            return Array<Self>()
        }
    }
    
    //MARK: - Save
    func save() throws{
        do {
            
            try managedObjectContext?.save()
            
            LogInfo("Insert row of \(objectID) into \(nameOfEntity()) table success ")
        }catch{
            LogError("Insert into \(nameOfEntity()) table failure: \(error)")
            throw error
        }
    }
    
}


