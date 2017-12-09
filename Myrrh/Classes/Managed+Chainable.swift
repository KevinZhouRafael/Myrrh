//
//  Managed+Chainable.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 27/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData


public extension Managed where Self:NSManagedObject{
    
    static var query:Query<Self>!{
        get{
            return Query<Self>(context:context, request: request)
        }
    }
    
  
}
