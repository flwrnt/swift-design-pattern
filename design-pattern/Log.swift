//
//  Log.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

struct Log: CustomStringConvertible {
    var body: String?
    
    public var description: String {
        return "\n------------------------------------\n\(body!)\n------------------------------------"
    }
    
    init(_ message: String? = nil) {
        self.body = message
    }
}
