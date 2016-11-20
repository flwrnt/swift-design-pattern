//
//  NotificationsCoreDataStore.swift
//  design-pattern
//
//  Created by Flwrnt on 20/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation
import CoreData

class NotificationCoreDataStoreService {
    let moc: NSManagedObjectContext
    
    init() {
        moc = AppDelegate.getMoc()!
    }
    
    func fetchNotifications(_ completionHandler: (Result<[Notifications]>) -> Void) {
        let request: NSFetchRequest = NSFetchRequest<Notifications>(entityName: "Notifications")
        
        do {
            let notifications = try moc.fetch(request).sorted {
                $0.receive_date!.timeIntervalSince1970 > $1.receive_date!.timeIntervalSince1970
            }
            return completionHandler(.success(notifications))
        } catch {
            print(Log("fetch notifications error: \(error)").description)
            return completionHandler(.fail(.coreData("error while fetching notifications")))
        }
    }
    
    func saveNotification(_ notification: Notification) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Notifications", into: moc) as! Notifications
        
        entity.id = notification.id
        entity.title = notification.title
        entity.body = notification.body
        entity.receive_date = notification.receiveDate as NSDate
        
        do {
            try moc.save()
            print(Log("notification saved"))
        } catch {
            fatalError(Log("save notification error: \(error)").description)
        }
    }
    
    func saveNotifications(_ notifications: [Notification]) {
        for notification in notifications {
            self.saveNotification(notification)
        }
    }
}
