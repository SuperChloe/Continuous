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
    
    func reset(timeDate: NSDate) {
        let today = NSDate()
        let realm = try! Realm()

            // Test
            if today.timeIntervalSinceDate(timeDate) >= 3 {
                let results = realm.objects(Habit).filter("rawInterval = 'year'")
                for habit: Habit in results {
                    try! realm.write {
                        habit.frequency = habit.goalFrequency
                        habit.addToStreak = true
                    }
                    print("Cool")
                }
            }
            
            // Yearly
            if today.timeIntervalSinceDate(timeDate) >= (86400 * 365) {
                print("Reset yearlies")
            }
            
            // Monthly
            if today.timeIntervalSinceDate(timeDate) >= (86400 * 30) {
                print("Reset monthlies")
            }

            // Weekly
            if today.timeIntervalSinceDate(timeDate) >= 604800 {
                print("Reset weeklies")
            }
            
            // Daily
            if today.timeIntervalSinceDate(timeDate) >= 86400 {
                let results = realm.objects(Habit).filter("rawInterval = 'day'")
                for habit: Habit in results {
                    try! realm.write {
                        habit.frequency = habit.goalFrequency
                        habit.addToStreak = true
                    }
                }
            }
    }
    
    func timePassed(date: NSDate, interval: String) -> NSDate {
        let yearComp = NSDateComponents()
        yearComp.year = 1
        let monthComp = NSDateComponents()
        monthComp.month = 1
        let weekComp = NSDateComponents()
        weekComp.weekOfYear = 1
        let dayComp = NSDateComponents()
        dayComp.day = 1
        
        let calendar = NSCalendar.currentCalendar()
        var result = NSDate()
        
        if interval == "year" {
            let yearResult = calendar.dateByAddingComponents(yearComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
            result = yearResult!
        }
        if interval == "month" {
            let monthResult = calendar.dateByAddingComponents(monthComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
            result = monthResult!
        }
        if interval == "week" {
            let weekResult = calendar.dateByAddingComponents(weekComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
            result = weekResult!
        }
        if interval == "day" {
            let dayResult = calendar.dateByAddingComponents(dayComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
            result = dayResult!
        }
        return result
    }
    
}
