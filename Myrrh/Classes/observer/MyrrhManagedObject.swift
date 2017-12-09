//
//  MyrrhManagedObject.swift
//  Myrrh
//
//  Created by Kevin Zhou on 19/10/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData

public class MyrrhManagedObject:NSManagedObject{
    
    public override func willSave() {
        super.willSave()
        
         LogInfo("changedValues:\(changedValues())")
        LogInfo("changedValuesForCurrentEvent:\(changedValuesForCurrentEvent())")
        LogInfo("hasPersistentChangedValues:\(hasPersistentChangedValues)")
        LogInfo("hasChanges:\(hasChanges)")

        //执行顺序
//        willSave()
//        didSave()
//        NSManagedObjectContextDidSave
        
        
//        if changedValue(forKey: #keyPath(Continent.countries)) != nil {
//
//            guard numberOfCountries != Int64(countries.count) else { return }
//            numberOfCountries = Int64(countries.count)
//
//            if countries.count == 0 {
//                guard isFault || markedForDeletionDate == nil else { return }
//                markedForDeletionDate = Date()
//            }
//
//        }
//
//        committedValue(forKey: #keyPath(Continent.countries)) as? Set<Country> ?? Set()

    }
    
    //
    public override func validateValue(_ value: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey key: String) throws {
        
        //example date is a proprity is Date
        //        if key == #keyPath(date) {
        //            guard let d = (value.pointee as? Date) else {
        //                return
        //            }
        //
        //            if d.timeIntervalSince1970 < 2508469598.9006691 {
        //                throw propertyValidationError(forKey: "date", localizedDescription: "date日期不能晚于\(Date(timeIntervalSince1970: 2508469598.9006691))")
        //            }
        //
        //        }
    }
    
    public override func validateForDelete() throws {
        try super.validateForDelete() //has super, can invoke validateValue
    }
    
    public override func validateForInsert() throws {
        try super.validateForInsert()
    }
    
    public override func validateForUpdate() throws {
        try super.validateForUpdate()
    }

    
    //TODO 批量删除，插入，更新的请求添加。
//    func abc() {
//        let batchUpdate = NSBatchUpdateRequest(entityName: "")
//        batchUpdate.resultType = .updatedObjectIDsResultType
//
//        guard let result = try! context.execute(batchUpdate) as? NSBatchUpdateResult else { fatalError("Wrong result type") }
//        guard let objectIDs = result.result as? [NSManagedObjectID] else { fatalError("Expected object IDs") }
//        let changes = [NSUpdatedObjectsKey: objectIDs]
//
//        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
//    }
}

