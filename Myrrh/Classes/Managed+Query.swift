//
//  DBModel+Query.swift
//  ActiveSQLite
//
//  Created by zhou kai on 08/06/2017.
//  Copyright © 2017 wumingapie@gmail.com. All rights reserved.
//

import Foundation
import CoreData

public extension Managed where Self:NSManagedObject{
    
    //MARK: - Find
    //MARK: - FindFirst
    static func findFirst()->Self?{
        return findFirst(nil, sortDecs: nil)
    }
    
    //MARK: - findFirst by one attribute
    static func findFirst(_ attribute: String, value:Any)->Self?{
        return findFirst([attribute:value])
    }
    
    static func findFirst(attribute:String, greaterThan value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, greaterThan: value))
    }
    static func findFirst(attribute:String, greaterThanOrEqualTo value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, greaterThanOrEqualTo: value))
    }
    static func findFirst(attribute:String, lessThan value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, lessThan: value))
    }
    static func findFirst(attribute:String, lessThanOrEqualTo value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, lessThanOrEqualTo: value))
    }
    static func findFirst(attribute:String, equalTo value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, equalTo: value))
    }
    static func findFirst(attribute:String, notEqualTo value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, notEqualTo: value))
    }
    static func findFirst(attribute:String, matches value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, matches: value))
    }
    static func findFirst(attribute:String, like value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, like: value))
    }
    
    static func findFirst(attribute:String, beginsWith value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, beginsWith: value))
    }
    
    static func findFirst(attribute:String, endsWith value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, endsWith: value))
    }
    
    static func findFirst(attribute:String, contains value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, contains: value))
    }
    
    //value is a Array
    static func findFirst(attribute:String, between value:Any)->Self? {
        return findFirst(NSComparisonPredicate(attribute: attribute, between: value))
    }
    
    //value is a Array
    static func findFirst(attribute:String, in value:Any)->Self?{
        return findFirst(NSComparisonPredicate(attribute: attribute, in: value))
    }
    
    static func findFirst(_ attrValueDic:Dictionary<String,Any>)->Self?{
        return findFirst(NSPredicate.newPredicate(attrValueDic))
    }
    
    //MARK: - predicate params
    static func findFirst(format predicateFormat: String, argumentArray arguments: [Any]?)->Self?{
        return findFirst(NSPredicate(format: predicateFormat, argumentArray: arguments))
    }
    
    static func findFirst(format predicateFormat: String, _ args: CVarArg...)->Self?{
        return findFirst(NSPredicate(format: predicateFormat, args))
    }
    
    static func findFirst(format predicateFormat: String, arguments argList: CVaListPointer)->Self?{
        return findFirst(NSPredicate(format: predicateFormat, arguments: argList))
    }
    
    //MARK: - order
    static func findFirst(sortItem:String,ascending:Bool = true)->Self?{
        return findFirst(sorts:[sortItem:ascending])
    }
    
    static func findFirst(sorts:[String:Bool])->Self?{
        return findFirst(nil, sortDecs: NSSortDescriptor.newSortDescriptors(sorts))
    }
    
    static func findFirst(_ preDic:Dictionary<String,Any>,sorts:[String:Bool])->Self?{
        return findFirst(NSPredicate.newPredicate(preDic), sortDecs: NSSortDescriptor.newSortDescriptors(sorts))
    }
    
    static func findFirst(predicate: NSPredicate,sorts:[String:Bool])->Self?{
        return findFirst(predicate,sortDecs:NSSortDescriptor.newSortDescriptors(sorts))
    }
    
    static func findFirst(_ predicate: NSPredicate,sortDesc: NSSortDescriptor)->Self?{
        return findFirst(predicate,sortDecs:[sortDesc])
    }
    
    static func findFirst(_ predicate: NSPredicate?,sortDecs: [NSSortDescriptor]? = nil)->Self?{
        
        if predicate != nil {
            
            guard let object = materializedObject(in: context, matching: predicate!) else {
                let request = requestFirst()
                request.predicate = predicate
                request.sortDescriptors = sortDecs
                request.returnsObjectsAsFaults = false
                return fetchFirst(request)
            }
            return object
            
        }else{
            let request = requestFirst()
            request.predicate = predicate
            request.sortDescriptors = sortDecs
            request.returnsObjectsAsFaults = false
            return fetchFirst(request)
        }
        
    }
    

    
    
    //MARK: FindAll
    static func findAll()->Array<Self>{
        return findAll(nil, sortDecs: nil)
    }
    
    //MARK: findAll by one attribute
    static func findAll(_ attribute: String, value:Any)->Array<Self>{
        return findAll([attribute:value])
    }
    
    static func findAll(attribute:String, greaterThan value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, greaterThan: value))
    }
    static func findAll(attribute:String, greaterThanOrEqualTo value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, greaterThanOrEqualTo: value))
    }
    static func findAll(attribute:String, lessThan value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, lessThan: value))
    }
    static func findAll(attribute:String, lessThanOrEqualTo value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, lessThanOrEqualTo: value))
    }
    static func findAll(attribute:String, equalTo value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, equalTo: value))
    }
    static func findAll(attribute:String, notEqualTo value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, notEqualTo: value))
    }
    static func findAll(attribute:String, matches value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, matches: value))
    }
    static func findAll(attribute:String, like value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, like: value))
    }
    
    static func findAll(attribute:String, beginsWith value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, beginsWith: value))
    }
    
    static func findAll(attribute:String, endsWith value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, endsWith: value))
    }
    
    static func findAll(attribute:String, contains value:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, contains: value))
    }
    
    //value is a Array
    static func findAll(attribute:String, between array:Any)->Array<Self> {
        return findAll(NSComparisonPredicate(attribute: attribute, between: array))
    }
    
    //value is a Array
    static func findAll(attribute:String, in array:Any)->Array<Self>{
        return findAll(NSComparisonPredicate(attribute: attribute, in: array))
    }
    
    
    static func findAll(_ attrValueDic:Dictionary<String,Any>)->Array<Self>{
        return findAll(NSPredicate.newPredicate(attrValueDic))
    }
    

    //MARK: - predicate params
    static func findAll(format predicateFormat: String, argumentArray arguments: [Any]?)->Array<Self>{
        return findAll(NSPredicate(format: predicateFormat, argumentArray: arguments))
    }
    
    static func findAll(format predicateFormat: String, _ args: CVarArg...)->Array<Self>{
        return findAll(NSPredicate(format: predicateFormat, args))
    }
    
    static func findAll(format predicateFormat: String, arguments argList: CVaListPointer)->Array<Self>{
        return findAll(NSPredicate(format: predicateFormat, arguments: argList))
    }

    
    //MARK: - order
    static func findAll(sortItem:String,ascending:Bool = true)->Array<Self>{
        return findAll(sorts:[sortItem:ascending])
    }
    
    static func findAll(sorts:[String:Bool])->Array<Self>{
        return findAll(nil, sortDecs: NSSortDescriptor.newSortDescriptors(sorts))
    }
    
    static func findAll(_ preDic:Dictionary<String,Any>,sorts:[String:Bool])->Array<Self>{
        return findAll(NSPredicate.newPredicate(preDic), sortDecs: NSSortDescriptor.newSortDescriptors(sorts))
    }
    
    static func findAll(predicate: NSPredicate,sorts:[String:Bool])->Array<Self>{
        return findAll(predicate,sortDecs:NSSortDescriptor.newSortDescriptors(sorts))
    }
    
    static func findAll(_ predicate: NSPredicate,sortDesc: NSSortDescriptor)->Array<Self>{
        return findAll(predicate,sortDecs:[sortDesc])
    }
    
    
    static func findAll(_ predicate: NSPredicate?,sortDecs: [NSSortDescriptor]? = nil)->Array<Self>{
        
        let request = requestAll()
        request.predicate = predicate
        request.sortDescriptors = sortDecs
        request.returnsObjectsAsFaults = false //maybe use to tableview
        request.fetchBatchSize = defaultBathSize
        return fetchAll(request)
    }
    
    
//    static func findOrCreate(_ predicate: NSPredicate, configure: (Self) -> ()) -> Self {
//
//        guard let object = findFirst(predicate) else {
//            //            let newObject: Self = create(in: context)
//            let newObject: Self = context.insertObject()
//            configure(newObject)
//            return newObject
//        }
//        return object
//    }
    
    static func findOrCreate(_ predicate: NSPredicate) -> Self {
        
        guard let object = findFirst(predicate) else {
            return createEntity()
        }
        return object
    }
    
    static func find(configurationRequest: (NSFetchRequest<Self>) -> () = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: Self.entityName)
        configurationRequest(request)
        return try! context.fetch(request)
    }
    
    static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        //registered && not Fault
        for object in context.registeredObjects where !object.isFault {
            //match class && match predicate
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        return nil
    }

}
