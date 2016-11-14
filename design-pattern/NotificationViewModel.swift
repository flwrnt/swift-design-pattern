//
//  NotificationViewModel.swift
//  design-pattern
//
//  Created by Flwrnt on 13/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

class NotificationViewModel {
    private var title: String = ""
    private var body: String = ""
    private var date: String = ""
    
    func configure(notification: Notifications) {
        self.title = notification.title!
        self.body = notification.body!
        self.date = formatDate(date: notification.receive_date as! Date)
    }
    
    private func formatDate(date: Date) -> String {
        let time = date.getTime()
        let day = date.getDay()
        
        return "Envoyé le \(day) à \(time)"
    }
    
    func getTitle() -> String {
        return self.title
    }
    func getBody() -> String {
        return self.body
    }
    func getDate() -> String {
        return self.date
    }

}
