//
//  Managed+Requests.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 06/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

var _defaultBatchSize = 20

extension Managed where Self:NSManagedObject{
    
    static var defaultBathSize:Int{
        set{
            //TODO synchronized
            _defaultBatchSize = newValue
        }
        get{
            return _defaultBatchSize
        }
    }
    

    static var request:NSFetchRequest<Self>!{
        get{
            return NSFetchRequest<Self>(entityName: entityName)
        }
    }
    
    static func requestAll(attribute:String,value:Any) -> NSFetchRequest<Self>{
        return requestAll(predicate: NSPredicate.newPredicate(attribute: attribute, value: value))
    }
    
    static func requestAll(sortItem:String,ascending:Bool = true,predicate:NSPredicate? = nil) -> NSFetchRequest<Self>{
        
        let request = requestAll(predicate: predicate)
        request.fetchBatchSize = defaultBathSize
        request.sortDescriptors = NSSortDescriptor.newSortDescriptors([sortItem:ascending])
        return request
    }
    
    static func requestAll(predicate:NSPredicate?) -> NSFetchRequest<Self>{
        let request = requestAll()
        request.predicate = predicate
        return request
        
    }

    static func requestAll()->NSFetchRequest<Self>{
        return NSFetchRequest<Self>(entityName: entityName)
    }
    
    static func requestFirst() -> NSFetchRequest<Self>{
        let request = requestAll()
        request.fetchLimit = 1
        return request
    }

    static func requestFirst(predicate:NSPredicate) -> NSFetchRequest<Self>{
        let request = requestAll(predicate: predicate)
        request.fetchLimit = 1
        return request
        
    }
    
    static func requestFirst(attribute:String,value:Any) -> NSFetchRequest<Self>{
        let request = requestAll(attribute: attribute, value: value)
        request.fetchLimit = 1
        return request
    }
    
    
    static func requestFirst(sortItem:String,ascending:Bool = true,predicate:NSPredicate? = nil) -> NSFetchRequest<Self>{
        
        let request = requestAll(sortItem: sortItem, ascending: ascending, predicate: predicate)
        request.fetchBatchSize = 1
        request.fetchLimit = 1
        return request
    }
    
}
