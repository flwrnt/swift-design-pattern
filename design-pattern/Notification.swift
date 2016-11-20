//
//  Todo.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

protocol Mappable {
    static func mapToModel(_ o: Any) -> Result<Self>
}


final class Notification: Mappable, Equatable, CustomStringConvertible {
    var id: String
    var title: String
    var body: String
    var receiveDate: Date
    
    // conform to custom string convertible protocol
    public var description: String {
        return "notification n° \(id) : \n\t title: \(title) \n\t body: \(body) \n\t date: \(receiveDate)"
    }
    
    init(id: String = UUID().uuidString, title: String, body: String, receiveDate: Date = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.receiveDate = receiveDate
    }
    
    // conform to mappable ptotocol
    internal static func mapToModel(_ o: Any) -> Result<Notification> {
        guard let notificationDic = o as? [String: AnyObject] else { return .fail(.parser) }
        
        if  let id = notificationDic["id"] as? String,
            let title = notificationDic["title"] as? String,
            let body = notificationDic["body"] as? String {
            
            return .success(Notification(id: id, title: title, body: body))
        }
        return .fail(.parser)
    }
    
    // conform to equatable protocol
    static func ==(lhs: Notification, rhs: Notification) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.body == rhs.body
    }
}
