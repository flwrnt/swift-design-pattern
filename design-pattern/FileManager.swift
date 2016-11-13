//
//  FileManager.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation


extension FileManager {
    private class func getPath(_ file: String) -> URL? {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            return URL(fileURLWithPath: dir).appendingPathComponent(file)
        }
        return nil
    }
    
    class func read(fileName: String) throws -> String? {
        guard let path: URL = self.getPath(fileName) else { throw Error.fileManager("file \(fileName) doesn't exist") }
        
        let content = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
        
        return content as String
    }
    
    class func write(content: String, fileName: String) throws {
        guard let path: URL = self.getPath(fileName) else { throw Error.fileManager("file \(fileName) doesn't exist") }

        try content.write(to: path, atomically: false, encoding: String.Encoding.utf8)
    }
}

