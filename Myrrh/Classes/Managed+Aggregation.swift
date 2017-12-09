//
//  Managed+Aggregation.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 06/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

public extension Managed where Self:NSManagedObject{
    
    static func countOfEntities(predicate:NSPredicate? = nil)->Int {
        do{
            let request = requestAll()
            request.predicate = predicate
            let count = try context.count(for: request)
            return count
        }catch{
            LogError("count of entities \(entityName) fails \(error)")
            return 0
        }
        
    }
}
