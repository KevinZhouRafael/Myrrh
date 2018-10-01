//
//  Utilities.swift
//  Myrrh
//
//  Created by kai zhou on 08/01/2018.
//  Copyright © 2018 hereigns. All rights reserved.
//

import Foundation
extension URL {
    static var temporary: URL {
        return URL(fileURLWithPath:NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(UUID().uuidString)
    }
    
    static var documents: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}
