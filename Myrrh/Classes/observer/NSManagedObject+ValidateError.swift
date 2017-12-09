//
//  NSManagedObject+ValidateError.swift
//  Myrrh
//
//  Created by Kevin Zhou on 20/10/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject{
    
    func propertyValidationError(forKey key: String, localizedDescription: String) -> NSError {
        let userInfo: [String:Any] = [
            NSValidationObjectErrorKey: self,
            NSValidationKeyErrorKey: key ,
            NSLocalizedDescriptionKey: localizedDescription
        ]
        let domain = Bundle(for: type(of: self)).bundleIdentifier ?? "undefined"
        return NSError(domain: domain, code: NSManagedObjectValidationError, userInfo: userInfo)
    }
    
    func validationError(withLocalizedDescription description: String) -> NSError {
        let userInfo: [String:Any] = [
            NSValidationObjectErrorKey: self,
            NSLocalizedDescriptionKey: description
        ]
        let domain = Bundle(for: type(of: self)).bundleIdentifier ?? "undefined"
        return NSError(domain: domain, code: NSManagedObjectValidationError, userInfo: userInfo)
    }
    
    func multipleValidationError(withLocalizedDescriptions descriptions: [String]) -> NSError {
        let userInfo: [AnyHashable : Any] = [
            NSDetailedErrorsKey: descriptions.map(validationError)
        ]
        let domain = Bundle(for: type(of: self)).bundleIdentifier ?? "undefined"
        return NSError(domain: domain, code: NSValidationMultipleErrorsError, userInfo: userInfo as! [String : Any])
    }
}
