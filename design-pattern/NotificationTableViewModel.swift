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
        var notifications = Notification.fetchAll()
        let parameters: Parameters = ["last_id": notifications.first?.id! ?? "0"]
        
        Request.send(url: "http://flwrnt.local/ios/getNotifications.php", params: parameters) { dataResult, response in
            print(Log("http response: \(response)"))
            print(Log("data result: \(dataResult)"))
            
            guard (response as! HTTPURLResponse).statusCode == 200 else { completion(.fail(.network("not a 200 response: \(response)"))); return }
            
            switch dataResult {
            case .success(let data):
                Parser.parse(data) { (result: Result<[Notification]>) -> Void in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let n):
                            if !n.isEmpty {
                                Notification.save(n)
                                notifications = Notification.fetchAll()
                            }
                            completion(.success(notifications))
                        case .fail(let error):
                            print(Log("error: \(error)"))
                        }
                    }
                }
            case .fail(let error):
                print(Log("error: \(error)"))
            }
            
        }
    }
    
    func getNotifications() -> [Notifications] {
        return Notification.fetchAll()
    }
}


