//
//  Parser.swift
//  design-pattern
//
//  Created by Flwrnt on 10/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

class Parser {
    class func parse<T: Mappable>(_ data: Data, completion: (Result<[T]>) -> Void) {
        
        let decodedData: Result<Any> = decodeData(data)
        
        switch decodedData {
            
        case .success(let result):
            
            guard let array = result as? [AnyObject] else { completion(.fail(.parser)); return }
            
            let result: Result<[T]> = arrayToModels(array)
            completion(result)
            
        case .fail:
            completion(.fail(.parser))
        }
    }
    
    private class func arrayToModels<T: Mappable>(_ objects: [AnyObject]) -> Result<[T]> {
        
        var convertAndCleanArray: [T] = []
        
        for object in objects {
            
            guard case .success(let model) = T.mapToModel(object) else { continue }
            convertAndCleanArray.append(model)
        }
        
        return .success(convertAndCleanArray)
    }
    
    private class func decodeData(_ data: Data) -> Result<Any> {
        do {
            let json: Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            return .success(json)
        }
        catch {
            return .fail(.parser)
        }
    }
}
