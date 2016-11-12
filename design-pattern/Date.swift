//
//  Date.swift
//  design-pattern
//
//  Created by Flwrnt on 12/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

extension Date {
    /**
     convert Date to String with format
     
     - parameter style: date style
     
     - returns: string representation of the date well formatted
     */
    func toString(style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = style
        
        return formatter.string(from: self)
    }
    
    /**
     convert Date to String with format
     
     - parameter format: date format
     
     - returns: string representation of the date well formatted
     */
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    /**
     get time from date
     
     - returns: date's time
     */
    func getTime(style: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.timeStyle = style
        
        return formatter.string(from: self)
    }
    
    /**
     get day from date
     
     - returns: date's day
     */
    func getDay(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = style
        formatter.timeStyle = .none
        
        return formatter.string(from: self)
    }
    
    func beautiful() -> String {
        let interval = abs(self.timeIntervalSinceNow).rounded()
        var result: String = "\u{1F550} "
        
        switch interval {
        case 0...60:
            result += "maintenant"
        case 61...3600:
            let time = abs(Int(interval.divided(by: 60)))
            result += "\(time) min"                                                       //format: 1min
        case 3601...86400:
            let time = abs(Int(interval.divided(by: 3600)))
            result += "\(time) h"                                                         //format: 1h
        case 86401...172802:
            result += "hier"
        case 172803...604800:
            result += self.toString(format: "EEEE")                                         //format: dim.
        case 604801...2592000:
            let time = abs(Int(interval.divided(by: 604800)))
            result += "\(time) sem"
        case 2592001...31536001:
            let time = abs(Int(interval.divided(by: 2592000)))
            result += "\(time) mois"
        default:
            result += self.toString(format: "dd/mm/yy")
        }
        return result
    }
}

extension String {
    /**
     convert String to Date
     
     - returns: date
     */
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
