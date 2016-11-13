//
//  Todo.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation
import CoreData

protocol Mappable {
    static func mapToModel(_ o: Any) -> Result<Self>
}


final class Notification: Mappable, Equatable, CustomStringConvertible {
    private var id: String
    private var title: String
    private var body: String
    private var receiveDate: Date
    
    // conform to custom string convertible protocol
    public var description: String {
        return "notification n° \(id) : \n\t title: \(title) \n\t body: \(body) \n\t date: \(receiveDate)"
    }
    
    let moc: NSManagedObjectContext
    
    init(id: String = UUID().uuidString, title: String, body: String, receiveDate: Date = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.receiveDate = receiveDate
        
        moc = AppDelegate.getMoc()!
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
    
    // accessors
    public func getId() -> String {
        return id
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getBody() -> String {
        return body
    }
    
    public func getReceiveDate() -> Date {
        return receiveDate
    }
    
    // conform to equatable protocol
    static func ==(lhs: Notification, rhs: Notification) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.body == rhs.body
    }
}

// MARK: - handle core data notifications

extension Notification {
    func save() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Notifications", into: moc) as! Notifications
        
        entity.id = self.getId()
        entity.title = self.getTitle()
        entity.body = self.getBody()
        entity.receive_date = self.getReceiveDate() as NSDate
        
        do {
            try moc.save()
            print(Log("notification saved"))
        } catch {
            fatalError(Log("save notification error: \(error)").description)
        }
    }
    
    class func save(_ notifications: [Notification]) {
        for notification in notifications {
            notification.save()
        }
    }
    
    class func fetchAll() -> [Notifications] {
        let moc = AppDelegate.getMoc()!
        let request: NSFetchRequest = NSFetchRequest<Notifications>(entityName: "Notifications")
        
        do {
            return try moc.fetch(request).sorted {
                $0.receive_date!.timeIntervalSince1970 > $1.receive_date!.timeIntervalSince1970
            }
        } catch {
            fatalError(Log("fetch notifications error: \(error)").description)
        }
    }
}
