//
//  Error.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    case network(String)
    case parser
}
