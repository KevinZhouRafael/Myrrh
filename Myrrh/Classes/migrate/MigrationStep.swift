//
//  MigrateStep.swift
//  Myrrh
//
//  Created by kai zhou on 08/01/2018.
//  Copyright © 2018 hereigns. All rights reserved.
//

import Foundation
import CoreData

public  final class MigrationStep {
    var source: NSManagedObjectModel
    var destination: NSManagedObjectModel
    var mappings: [NSMappingModel]
    init(source: NSManagedObjectModel, destination: NSManagedObjectModel, mappings: [NSMappingModel])
    {
        self.source = source
        self.destination = destination
        self.mappings = mappings
    }
    
}
