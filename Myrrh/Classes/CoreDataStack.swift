//
//  MoodyStack.swift
//  Moody
//
//  Created by Florian on 18/08/15.
//  Copyright © 2015 objc.io. All rights reserved.
//

import CoreData


public class CoreDataStack{
    public static let shared:CoreDataStack = CoreDataStack()
    
    var mainContext:NSManagedObjectContext!
    
    private var persistentContainer:NSPersistentContainer?
    private var persistentContainerInMemory:NSPersistentContainer?
    private var persistentStoreCoordinator:NSPersistentStoreCoordinator?
    private var persistentStoreCoordinatorInMemory:NSPersistentStoreCoordinator?
    
    //    private init() {
    //        _ = self.context
    //    }
    
    public var context:NSManagedObjectContext{
        get{
            return persistentContainer!.viewContext
        }
    }
    public var contextMemory:NSManagedObjectContext{
        get{
            return persistentContainerInMemory!.viewContext
        }
    }
    
    @available(iOS 10.0, *)
    public func setPersistentContainer(xcdatamodeldName:String){
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: xcdatamodeldName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

            //megration
            
//            if error == nil {
//                moodyContainer.viewContext.mergePolicy = MoodyMergePolicy(mode: .local)
//                DispatchQueue.main.async { completion(moodyContainer) }
//            } else {
//                guard !migrating else { fatalError("was unable to migrate store") }
//                DispatchQueue.global(qos: .userInitiated).async {
//                    migrateStore(from: storeURL, to: storeURL, targetVersion: MoodyModelVersion.current, deleteSource: true, progress: progress)
//                    createMoodyContainer(migrating: true, progress: progress,
//                                         completion: completion)
//                }
//            }
            
        })

        persistentContainer = container
        mainContext = persistentContainer!.viewContext
        //        container.newBackgroundContext() NSPrivateQueueConcurrencyType
        
        
    }
    
    @available(iOS 10.0, *)
    public func setPersistentContainerMemory(xcdatamodeldName:String){
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: xcdatamodeldName)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainerInMemory = container
        mainContext = persistentContainerInMemory!.viewContext
    }
    
    //MARK: - < 10.0
    func setPersistentContainer(for aModelClass: Swift.AnyClass,storeURL:URL,autoMigrate:Bool = true) {

        let bundles = [Bundle(for: aModelClass)]
        guard let model = NSManagedObjectModel
            .mergedModel(from: bundles)
            else { fatalError("model not found") }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        try! psc.addPersistentStore(ofType: NSSQLiteStoreType,
                                    configurationName: nil,
                                    at: storeURL,
                                    options: (autoMigrate ? [NSMigratePersistentStoresAutomaticallyOption:true,
                                                             NSInferMappingModelAutomaticallyOption:true]:nil))
        
//        try! psc.addPersistentStore(ofType: NSSQLiteStoreType,
//                                    configurationName: nil,
//                                    at: storeURL,
//                                    options: nil)
        

        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
        persistentStoreCoordinator = psc
        mainContext = context
    }
    
    func setPersistentContainerInMemory(for aModelClass: Swift.AnyClass) {
        
        let bundles = [Bundle(for: aModelClass)]
        guard let model = NSManagedObjectModel
            .mergedModel(from: bundles)
            else { fatalError("model not found") }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! psc.addPersistentStore(ofType: NSInMemoryStoreType,
                                    configurationName: nil,
                                    at: nil,
                                    options: nil)
        
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
        persistentStoreCoordinatorInMemory = psc
        mainContext = context
    }
    
    
    // MARK: - Core Data Saving support
    func saveContext (completion:((_ error:NSError?)->Void)? = nil) {
        let context = mainContext!
        if context.hasChanges {
            do {
                try context.save()
                completion?(nil)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                completion?(nserror)
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



//func createMoodyContainer(completion: @escaping (NSPersistentContainer) -> ()) {
//    let container = NSPersistentContainer(name: "Moody")
//    container.loadPersistentStores { _, error in
//        guard error == nil else { fatalError("Failed to load store: \(String(describing: error))") }
//        DispatchQueue.main.async { completion(container) }
//    }
//}


