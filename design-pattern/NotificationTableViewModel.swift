//
//  NotificationViewModel.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

class NotificationTableViewModel: APIControllerProtocol {
    var notifications: Array<Notification> = []
    
    lazy var api: APIController = APIController(delegate: self)
    
    func didReceiveAPIResults(_ results: Any) {
        guard let array = results as? Dictionary<String, Any> else { return }
        guard let notifications = array["notifications"] as? Array<Dictionary<String, Any>> else { return }
        
        print(Log("\(notifications)").description)
        
        for notification in notifications {
            let mapNotification = try! Notification.mapToModel(notification)
            
            switch mapNotification {
            case .success(let n):
                self.notifications.append(n)
                print(Log("notifications : \(self.notifications)").description)
            case .fail(Error.parser):
                print(Log("\(mapNotification)").description)
            default:
                print(Log("\(mapNotification)").description)
            }
        }
    }
}
