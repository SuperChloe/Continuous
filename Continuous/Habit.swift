//
//  Habit.swift
//  Continuous
//
//  Created by Chloe on 2016-02-23.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation
import RealmSwift

enum Interval: String {
    case Daily = "day"
    case Weekly = "week"
    case Monthly = "month"
    case Yearly = "year"
}

let intervalSort: [Interval : Int] = [
    .Daily : 0,
    .Weekly : 1,
    .Monthly : 2,
    .Yearly : 3
]

class Habit: Object {
    
    dynamic var name: String!
    dynamic var goalFrequency = 0
    dynamic var frequency = 0
    
    private dynamic var rawInterval: String!
    var interval: Interval! {
        get {
            if let i = Interval(rawValue: rawInterval) {
                return i
            }
            return .Daily
        }
        set {
            rawInterval = newValue.rawValue
        }
    }
    
    dynamic var sortingIndex = 0
    dynamic var creationDate: NSDate!
    dynamic var currentStreak = 0
    dynamic var longestStreak = 0
    dynamic var addToStreak = true
    dynamic var intervalDate: NSDate!
    let datesDone = List<Date>()

    convenience required init(habitName: String, habitFrequency: Int, habitInterval: Interval, date: NSDate) {
        self.init()
        name = habitName
        goalFrequency = habitFrequency
        frequency = habitFrequency
        interval = habitInterval
        sortingIndex = intervalSort[habitInterval]!
        creationDate = date
        intervalDate = creationDate
    }
    
    func changeFrequency() {
        if frequency == 1 && addToStreak == true {
            try! Realm().write {
                currentStreak = currentStreak + 1
                if currentStreak > longestStreak {
                    longestStreak = currentStreak
                }
                frequency = 0
                let date = Date()
                //                let comp = NSDateComponents()
                //                comp.day = 15
                //                comp.month = 2
                //                comp.year = 2016
                //                date.date = NSCalendar.currentCalendar().dateFromComponents(comp)!
                datesDone.insert(date, atIndex: 0)
                addToStreak = false
                
                for notification: UILocalNotification in UIApplication.sharedApplication().scheduledLocalNotifications! {
                    if (notification.userInfo!["Creation"] as! NSDate == creationDate) {
                        UIApplication.sharedApplication().cancelLocalNotification(notification)
                    }
                }
            }
            return
        }
        
        if frequency == 0 {
            return
        }
        
        try! Realm().write {
            frequency = frequency - 1
            let date = Date()
            //            let comp = NSDateComponents()
            //            comp.day = 14
            //            comp.month = 2
            //            comp.year = 2016
            //            date.date = NSCalendar.currentCalendar().dateFromComponents(comp)!
            datesDone.insert(date, atIndex: 0)
        }
    }
}
 