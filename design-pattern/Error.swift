//
//  Error.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

enum Error: Swift.Error, CustomStringConvertible {
    case network(String)
    case parser
    case fileManager(String)
    
    public var description: String {
        switch self {
        case .network(let error):
            return error
        case .fileManager(let error):
            return error
        default:
            return self.description
        }
    }
}
