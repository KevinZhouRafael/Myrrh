//
//  NSComparisonPredicate.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 21/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation

extension NSComparisonPredicate{
    
    convenience init(attribute:String, greaterThan value:Any) {
        self.init(attribute: attribute, operatorType: .greaterThan, value: value)
    }
    convenience init(attribute:String, greaterThanOrEqualTo value:Any) {
        self.init(attribute: attribute, operatorType: .greaterThanOrEqualTo, value: value)
    }
    convenience init(attribute:String, lessThan value:Any) {
        self.init(attribute: attribute, operatorType: .lessThan, value: value)
    }
    convenience init(attribute:String, lessThanOrEqualTo value:Any) {
        self.init(attribute: attribute, operatorType: .lessThanOrEqualTo, value: value)
    }
    convenience init(attribute:String, equalTo value:Any) {
        self.init(attribute: attribute, operatorType: .equalTo, value: value)
    }
    convenience init(attribute:String, notEqualTo value:Any) {
        self.init(attribute: attribute, operatorType: .notEqualTo, value: value)
    }
    convenience init(attribute:String, matches value:Any) {
        self.init(attribute: attribute, operatorType: .matches, value: value)
        //    let predicate = NSPredicate(format: "%K MATCHES[n] %@", #keyPath(Country.alpha3Code), "[AB][FLH](.)")
    }
    convenience init(attribute:String, like value:Any) {
        self.init(attribute: attribute, operatorType: .like, value: value)
        //    let predicate = NSPredicate(format: "%K LIKE[n] %@", #keyPath(Country.alpha3Code), "?A?")
    }
    
    
    convenience init(attribute:String, beginsWith value:Any) {
        self.init(attribute: attribute, operatorType: .beginsWith, value: value)
        //    let predicate = NSPredicate(format: "%K BEGINSWITH[n] %@", #keyPath(Country.alpha3Code), "CA")
    }
    
    
    convenience init(attribute:String, endsWith value:Any) {
        self.init(attribute: attribute, operatorType: .endsWith, value: value)
        //    let predicate = NSPredicate(format: "%K ENDSWITH[n] %@", #keyPath(Country.alpha3Code), "K")
    }
    
    convenience init(attribute:String, contains value:Any) {
        self.init(attribute: attribute, operatorType: .contains, value: value)
        //let predicate = NSPredicate(format: "%K CONTAINS[n] %@", #keyPath(Country.alpha3Code), "IN")
    }
    
    //value is a Array
    convenience init(attribute:String, between array:Any) {
        self.init(attribute: attribute, operatorType: .between, value: array)
        //        let predicate = NSPredicate(format: "%K BETWEEN %@", #keyPath(Person.age), [23, 28]).predicateFormat
        //        let predicate = NSPredicate(format: "%K BETWEEN {%ld, %ld}", #keyPath(Person.age), 23, 28).predicateFormat
    }
    
    //value is a Array
    convenience init(attribute:String, in array:Any) {
        self.init(attribute: attribute, operatorType: .in, value: array)
        //let predicate = NSPredicate(format: "%K IN[n] %@",#keyPath(Country.alpha3Code), ["FRA", "FIN", "ISL"])
    }
    
    
    
    convenience init(attribute:String,operatorType:NSComparisonPredicate.Operator,value:Any){
        self.init(leftConstantValue: attribute, rightConstantValue: value, type: operatorType)
    }
    
    convenience init(leftConstantValue lcv: Any, rightConstantValue rcv: Any,type: NSComparisonPredicate.Operator){
        self.init(leftExpression: NSExpression(forConstantValue: lcv),
                  rightExpression: NSExpression(forConstantValue: rcv),
                  modifier: .direct,
                  type: type,
                  options: [])
    }
    
    convenience init(leftExpression lhs: NSExpression, rightExpression rhs: NSExpression,type: NSComparisonPredicate.Operator){
        self.init(leftExpression: lhs,rightExpression: rhs,modifier: .direct,type: type,options: [])
    }

}
