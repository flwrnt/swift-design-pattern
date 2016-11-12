//
//  NotificationViewModel.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation
import CoreData

class NotificationTableViewModel {
    
    func notificationsRequest(_ completion: @escaping (Result<[Notifications]>) -> Void) {
        Request.send(url: "http://flwrnt.local/ios/getNotifications.php") { data, response in
            print(Log("http response: \(response)"))
            print(Log("data result: \(data)"))

            Parser.parse(data.value!) { (result: Result<[Notification]>) -> Void in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let n):
                        Notification.save(n)
                        completion(.success(Notification.fetchAll()))
                    case .fail(let error):
                        print(Log("error: \(error)"))
                    }
                }
            }
        }
    }
    
    func getNotifications() -> [Notifications] {
        return Notification.fetchAll()
    }
}


