//
//  FileManager.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation


extension FileManager {
    class func getPath(file: String) -> URL? {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            return URL(fileURLWithPath: dir).appendingPathComponent(file)
        }
        return nil
    }
    
    class func read(path: URL) throws -> String? {
        let content = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
        
        return content as String
    }
    
    class func write(content: String, path: URL) {
        do {
            try content.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        }
        catch {
            /* error handling here */
            print("error writing new token to file: \(error)")
        }
    }
}

