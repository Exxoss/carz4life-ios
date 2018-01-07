//
//  FormatingHelper.swift
//  carz4life
//
//  Created by Arthur Quemard on 04/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation


func stringFromTimeInterval(interval: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.year, .month, .weekOfMonth, .day , .hour, .minute, .second]
    formatter.unitsStyle = .full
    formatter.maximumUnitCount = 2

    return formatter.string(from: interval)!
}

func stringFromPrices(price: Float) -> String {
    let formatter = NumberFormatter()
    
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "de_CH")
    
    return formatter.string(from: (price as NSNumber))!
}

func dateFromString(dateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    
    return formatter.date(from: dateString)!
}

func timeIntervalRemainingFromDate(date: Date?) -> TimeInterval {
    
    var time = TimeInterval(0)
    if date != nil {
        time = (date?.timeIntervalSinceNow)!
        
        if time < 0 {
            return TimeInterval(0)
        }
    }
    return time
}
