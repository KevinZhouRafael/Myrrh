//
//  NSPredicate+Myrrh.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 04/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

extension NSPredicate{

    convenience init(_ preDic:Dictionary<String,Any>) {
        var format = ""
        var arguments = [Any]()
        for (attribute, value) in preDic {
            if format.lengthOfBytes(using: .utf8) > 0 {
                format += " AND "
            }
            format += "\(attribute) == %@"
            arguments.append(value)
            
        }
        
        if arguments.count == 0 {
           self.init()
        }else{
           self.init(format: format, argumentArray: arguments)
        }
        
    }
    class func newPredicate(_ preDic:Dictionary<String,Any>)->NSPredicate?{
        
        var format = ""
        var arguments = [Any]()
        for (attribute, value) in preDic {
            if format.lengthOfBytes(using: .utf8) > 0 {
                format += " AND "
            }
            format += "\(attribute) == %@"
            arguments.append(value)
            
        }
        
        if arguments.count == 0 {
            return nil
        }
        return NSPredicate(format: format, argumentArray: arguments)
        
    }
    
    class func newPredicate(attribute:String,value:Any)->NSPredicate?{
        var predicate:NSPredicate? = nil
        
        let mir = Mirror(reflecting:value)
        switch mir.subjectType {
            
        case _ as String.Type, _ as  Optional<String>.Type,_ as String?.Type:
            predicate = NSPredicate(format: "%K = %@", attribute,value as! String)
            break;
            
        case _ as Date.Type, _ as Optional<Date>.Type,_ as Date?.Type,
             _ as NSDate.Type, _ as Optional<NSDate>.Type,_ as NSDate?.Type:
            predicate = NSPredicate(format: "%K = %@", attribute,value as! NSDate)
            break
            

        case _ as Int.Type, _ as Optional<Int>.Type, _ as Int?.Type,
             _ as Int8.Type, _ as Optional<Int8>.Type, _ as Int8?.Type,
             _ as Int16.Type, _ as Optional<Int16>.Type, _ as Int16?.Type,
             _ as Int32.Type, _ as Optional<Int32>.Type, _ as Int32?.Type,
             _ as Int64.Type, _ as Optional<Int64>.Type, _ as Int64?.Type:
            predicate = NSPredicate(format: "%K = %ld", attribute,value as! Int64)
            break
            
        case _ as Float.Type, _ as Optional<Float>.Type, _ as Float?.Type:
            predicate = NSPredicate(format: "%K = %%a", attribute,value as! Float)
            break
        
        case _ as Double.Type, _ as Optional<Double>.Type, _ as Double?.Type:
            predicate = NSPredicate(format: "%K = %%la", attribute,value as! Double)
            break
            
        case _ as NSNumber.Type, _ as  Optional<NSNumber>.Type,_ as NSNumber?.Type:
            predicate = NSPredicate(format: "%K = %@", attribute,value as! NSNumber)
            break
            
        default: break
            
        }

        return predicate
    }

}
