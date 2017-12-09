//
//  NSSortDescriptor+Myrrh.swift
//  CoreDataSample
//
//  Created by Kevin Zhou on 04/09/2017.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import CoreData
extension NSSortDescriptor{
    class func newSortDescriptors(_ sortDic:Dictionary<String,Bool>)->[NSSortDescriptor]{
        var sorts = [NSSortDescriptor]()
        for (key,value) in sortDic {
            sorts.append(NSSortDescriptor(key: key, ascending: value))
        }
        return sorts
    }

}
