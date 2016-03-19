//
//  Reset.swift
//  Continuous
//
//  Created by Chloe on 2016-03-01.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation
import RealmSwift

struct Reset {
    
    let realm = try! Realm()
    
    func checkReset() {
        let today = NSDate()
        let results = realm.objects(Habit)
        
        for habit: Habit in results {
            // Yearly
            if today.timeIntervalSinceDate(habit.intervalDate) >= (86400 * 365) {
                resetValues(habit)
            }
            // Monthly
            if today.timeIntervalSinceDate(habit.intervalDate) >= (86400 * 30) {
                resetValues(habit)
            }
            // Weekly
            if today.timeIntervalSinceDate(habit.intervalDate) >= 604800 {
                resetValues(habit)
            }
            // Daily
            if today.timeIntervalSinceDate(habit.intervalDate) >= 86400 {
                resetValues(habit)
            }
//            // Test (3 secs)
//            if today.timeIntervalSinceDate(habit.intervalDate) >= 3 {
//                resetValues(habit)
//            }
        }
        
    }
    
    func resetValues(habit: Habit) {
        try! realm.write {
            if habit.addToStreak == true {
                habit.currentStreak = 0
            }
            habit.frequency = habit.goalFrequency
            habit.addToStreak = true
            habit.intervalDate = NSDate()
        }
        
        
        let pushNotification = UILocalNotification()
        pushNotification.alertBody = "Did you \(habit.name) this \(habit.interval.rawValue)"
        pushNotification.alertAction = "Open"
        pushNotification.fireDate = NSDate()
        pushNotification.soundName = UILocalNotificationDefaultSoundName
        pushNotification.userInfo = ["Creation": habit.creationDate]
        pushNotification.userInfo = ["UUID" : habit.uuid]
        pushNotification.category = "HABIT_CATEGORY"
        switch habit.interval as Interval {
            case .Daily: pushNotification.repeatInterval = .Day
            case .Weekly: pushNotification.repeatInterval = .WeekOfYear
            case .Monthly: pushNotification.repeatInterval = .Month
            case .Yearly: pushNotification.repeatInterval = .Year
        }
//        pushNotification.repeatInterval = .Minute
        UIApplication.sharedApplication().scheduleLocalNotification(pushNotification)
    }
    
}
