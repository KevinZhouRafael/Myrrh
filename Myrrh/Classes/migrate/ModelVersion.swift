//
//  ModelVersion.swift
//  Myrrh
//
//  Created by kai zhou on 08/01/2018.
//  Copyright © 2018 hereigns. All rights reserved.
//

import Foundation
import CoreData

public protocol ModelVersion: Equatable {
    static var all: [Self] { get }
    static var current: Self { get }
    var name: String { get }
    var successor: Self? { get }
    var modelBundle: Bundle { get }
    var modelDirectoryName: String { get }
    func mappingModelsToSuccessor() -> [NSMappingModel]?
}

extension ModelVersion {
    // url -> metadata -> first ModelVersion (first through NSManagedObjectModel with metadata)
    public init?(storeURL: URL) {
        guard let metadata = try? NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType,at: storeURL, options: nil) else { return nil }
        
        let version = Self.all.first {
            $0.managedObjectModel().isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata)
        }
        guard let result = version else { return nil }
        self = result
    }
    
    //modelDirectoryName -> NSManagedObjectModel
    public func managedObjectModel() -> NSManagedObjectModel {
        let omoURL = modelBundle.url(forResource: name, withExtension: "omo", subdirectory: modelDirectoryName)
        let momURL = modelBundle.url(forResource: name, withExtension: "mom", subdirectory: modelDirectoryName)
        guard let url = omoURL ?? momURL else {
            fatalError("model version \(self) not found")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("cannot open model at \(url)") }
        return model
        
    }
    
    public func mappingModelsToSuccessor() -> [NSMappingModel]? {
        guard let nextVersion = successor else { return nil }
        guard let mapping = NSMappingModel(from: [modelBundle],
                                           forSourceModel: managedObjectModel(),
                                           destinationModel: nextVersion.managedObjectModel())else {
            fatalError("no mapping from \(self) to \(nextVersion)")
                                            
        }
        
        return [mapping]
        
    }
    
    public func mappingModelToSuccessor() -> NSMappingModel? {
        guard let nextVersion = successor else { return nil }
        guard let mapping = NSMappingModel(from: [modelBundle],
                                           forSourceModel: managedObjectModel(),
                                           destinationModel: nextVersion.managedObjectModel()) else {
            fatalError("no mapping model found for \(self) to \(nextVersion)")
        }
        
        return mapping
    }
    
    public func migrationSteps(to version: Self) -> [MigrationStep] {
        guard self != version else { return [] }
        guard let mappings = mappingModelsToSuccessor(),let nextVersion = successor else {
                fatalError("couldn't  nd mapping models")
        }
        
        let step = MigrationStep(source: managedObjectModel(),
                                 destination: nextVersion.managedObjectModel(),
                                 mappings: mappings)
        return [step] + nextVersion.migrationSteps(to: version)
        
    }
    
}





