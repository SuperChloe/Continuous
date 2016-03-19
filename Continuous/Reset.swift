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
            switch habit.interval! {
            case .Yearly:
                if !DateComparison.isSameYear(habit.intervalDate, date2: today) {
                    resetValues(habit)
                }
            case .Monthly:
                if !DateComparison.isSameMonth(habit.intervalDate, date2: today) {
                    resetValues(habit)
                }
            case .Weekly:
                if !DateComparison.isSameWeek(habit.intervalDate, date2: today) {
                    resetValues(habit)
                }
            case .Daily:
                if !DateComparison.isSameDay(habit.intervalDate, date2: today) {
                    resetValues(habit)
                }
            }
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
