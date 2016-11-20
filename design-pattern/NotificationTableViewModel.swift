//
//  NotificationViewModel.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class NotificationTableViewModel {
    let notificationsCoreDataStore = NotificationCoreDataStoreService()
    
    func notificationsRequest(headers: HttpHeaders = [:], parameters: Parameters = [:], _ completion: ((Result<[Notifications]>) -> Void)? = nil) {
        
        Request.send(url: Const.Url.getNotifications, headers: headers, params: parameters) { dataResult, response in
            switch dataResult {
            case .success(let data):
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completion?(.fail(.network("not a 200 response: \(response)"))); return
                }

                Parser.parse(data) { (result: Result<[Notification]>) -> Void in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let n):
                            var notifications = [Notifications]()
                            if !n.isEmpty {
                                self.notificationsCoreDataStore.saveNotifications(n)
                                notifications = self.getNotifications()
                            }
                            completion?(.success(notifications))
                        case .fail(let error):
                            print(Log("error: \(error)"))
                        }
                    }
                }
            case .fail(let error):
                print(Log("error: \(error.localizedDescription)"))
            }
            
        }
    }
    
    func getNotifications() -> [Notifications] {
        var notif = [Notifications]()
        
        notificationsCoreDataStore.fetchNotifications() { result in
            switch result {
            case .success(let notifications):
                notif = notifications
            case .fail(let error):
                print(Log("error: \(error)"))
            }
        }
        return notif
    }
}


