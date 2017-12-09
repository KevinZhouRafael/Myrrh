//
//  Myrrh.swift
//  Myrrh
//
//  Created by Kevin Zhou on 29/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

public var logLevel: LogLevel = .info

public func save(){
    CoreDataStack.shared.mainContext.saveOrRollback()
}

public func save(_ complete:()->()){
    CoreDataStack.shared.mainContext.save(complete: complete, fails: nil)
}

public func performChanges(block: (() -> ())? = nil) {
    CoreDataStack.shared.mainContext.performChanges(block: block)
}

public func performChangesAndWait(_ block: (() -> ())? = nil) {
    CoreDataStack.shared.mainContext.performChangesAndWait(block)
}

public var mainContext:NSManagedObjectContext{
    return CoreDataStack.shared.mainContext
}

public func setPersistentContainer(xcdatamodeldName: String){
    CoreDataStack.shared.setPersistentContainer(xcdatamodeldName: xcdatamodeldName)
}

public func setPersistentContainer(aModelClass:AnyClass,storeURL: URL){
    CoreDataStack.shared.setPersistentContainer(for: aModelClass, storeURL: storeURL)
}

