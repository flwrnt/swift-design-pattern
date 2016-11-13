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
    let notificationsTableView: UITableView
    var notifications = [Notifications]() {
        didSet {
            notificationsTableView.reloadData()
        }
    }
    
    init(tableView: UITableView) {
        self.notificationsTableView = tableView
        self.getNotifications()
    }
    
    func countNotifications() -> Int {
        return self.notifications.count
    }
    
    func getNotification(at index: Int) -> Notifications {
        return self.notifications[index]
    }
    
    func notificationsRequest(_ completion: @escaping (Result<[Notifications]>) -> Void) {
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
                                self.getNotifications()
                            }
                            completion(.success(self.notifications))
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
    
    private func getNotifications(){
        self.notifications = Notification.fetchAll()
    }
}


