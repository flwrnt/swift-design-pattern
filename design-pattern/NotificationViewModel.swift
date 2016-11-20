//
//  NotificationViewModel.swift
//  design-pattern
//
//  Created by Flwrnt on 13/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

class NotificationViewModel {
    var notification: Notifications?
    
    var title: String {
        return notification!.title!
    }
    var body: String {
        return notification!.body!
    }
    var date: String {
        return formatDate(date: notification!.receive_date! as Date)
    }
    
    func configure(notification: Notifications) {
        self.notification = notification
    }
    
    private func formatDate(date: Date) -> String {
        let time = date.getTime()
        let day = date.getDay()
        
        return "Envoyé le \(day) à \(time)"
    }
}
