//
//  Query.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 27/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

public class Query<T:Managed> where T:NSManagedObject {
    private var context:NSManagedObjectContext!
    private var request:NSFetchRequest<T>!
    
    convenience init(context:NSManagedObjectContext,request:NSFetchRequest<T>){
        self.init()
        self.context = context
        self.request = request
    }
    
    
    func `where`(_ attribute: String, value:Any) -> Self{
        return self.where(attrValueDic:[attribute:value])
    }
    
    func `where`(attribute:String, greaterThan value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, greaterThan: value))
    }
    func `where`(attribute:String, greaterThanOrEqualTo value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, greaterThanOrEqualTo: value))
    }
    func `where`(attribute:String, lessThan value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, lessThan: value))
    }
    func `where`(attribute:String, lessThanOrEqualTo value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, lessThanOrEqualTo: value))
    }
    func `where`(attribute:String, equalTo value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, equalTo: value))
    }
    func `where`(attribute:String, notEqualTo value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, notEqualTo: value))
    }
    func `where`(attribute:String, matches value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, matches: value))
    }
    func `where`(attribute:String, like value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, like: value))
    }
    
    func `where`(attribute:String, beginsWith value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, beginsWith: value))
    }
    
    func `where`(attribute:String, endsWith value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, endsWith: value))
    }
    
    func `where`(attribute:String, contains value:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, contains: value))
    }
    
    //value is a Array whitch count is 2
    func `where`(attribute:String, between array:Any) -> Self {
        return self.where(NSComparisonPredicate(attribute: attribute, between: array))
    }
    
    //value is a Array whitch count is 2
    func `where`(attribute:String, in array:Any) -> Self{
        return self.where(NSComparisonPredicate(attribute: attribute, in: array))
    }
    
    
    //MARK: `where` by more attributes
    func `where`(attrValueDic:Dictionary<String,Any>) -> Self{
        return self.where(NSPredicate.newPredicate(attrValueDic))
    }
    
    func `where`(format predicateFormat: String, argumentArray arguments: [Any]?)->Self{
        return self.where(NSPredicate(format: predicateFormat, argumentArray: arguments))
    }
    
    func `where`(format predicateFormat: String, _ args: CVarArg...)->Self?{
        return self.where(NSPredicate(format: predicateFormat, args))
    }
    
    func `where`(format predicateFormat: String, arguments argList: CVaListPointer)->Self{
        return self.where(NSPredicate(format: predicateFormat, arguments: argList))
    }
    
    func `where`(_ predicate:NSPredicate?) -> Self{
        
        if let oldPredicate = request.predicate, let newPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [oldPredicate,newPredicate])
        }else if let newPredicate = predicate{
            request.predicate = newPredicate
        }
        
        return self
    }
    
    
    func order(sortItem:String,ascending:Bool = true) -> Self{
        return order(sorts:[sortItem:ascending])
    }

    func order(sorts:[String:Bool]) -> Self{
        return order(sortDescs: NSSortDescriptor.newSortDescriptors(sorts))
    }

    func order(sortDesc: NSSortDescriptor) -> Self{
        return order(sortDescs: [sortDesc])
//        if let _ = request.sortDescriptors {
//            request.sortDescriptors?.append(sortDesc)
//        }else{
//            request.sortDescriptors = [sortDesc]
//        }
//
//        return self
    }
    
    func order(sortDescs:[NSSortDescriptor]) -> Self {
        if let _ = request.sortDescriptors {
            request.sortDescriptors?.append(contentsOf: sortDescs)
        }else{
            request.sortDescriptors = sortDescs
        }
        
        return self
    }

    func limit(limit:Int) -> Self {
        request.fetchBatchSize = limit
        return self
    }
    
    //MARK: - execute
    func page(page:Int) -> Array<T> {
        request.fetchOffset = request.fetchLimit * (page - 1)
        return fetch()
    }
    
    func all() -> Array<T> {
        return fetch()
    }
    
    func first() -> T? {
        request.fetchLimit = 1
        request.fetchOffset = 0
        return fetch().first
    }
    
    func fetch(_ returnsObjectsAsFaults:Bool = false) -> Array<T>{
        request.returnsObjectsAsFaults = returnsObjectsAsFaults
        do{
            let results = try context.fetch(request)
            LogInfo("Find rows of \(request.entityName ?? "") success.")
            return results
        }catch{
            LogError("Find rows of \(request.entityName ?? "") fails \(error)")
            return Array<T>()
        }
    }
    
    func delete() -> Bool{
        request.returnsObjectsAsFaults = true
        request.includesPropertyValues = false
        let objectsToTruncate = fetch(request.returnsObjectsAsFaults)
        for objectToTruncate in objectsToTruncate {
            objectToTruncate.deleteEntity()
        }
        return true
    }

}
