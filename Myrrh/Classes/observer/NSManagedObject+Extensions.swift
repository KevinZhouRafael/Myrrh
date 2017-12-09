//
//  NSManagedObject+Extensions.swift
//  Myrrh
//
//  Created by Kevin Zhou on 20/10/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    public func changedValue(forKey key: String) -> Any? {
        return changedValues()[key]
    }
    public func committedValue(forKey key: String) -> Any? {
        return committedValues(forKeys: [key])[key]
    }
}
