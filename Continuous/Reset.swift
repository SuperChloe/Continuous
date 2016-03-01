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

            // TEST 3 SECS
//            if today.timeIntervalSinceDate(timeDate) >= 3 {
//                let results = realm.objects(Habit).filter("rawInterval = 'year'")
//                for habit: Habit in results {
//                    try! realm.write {
//                        habit.frequency = habit.goalFrequency
//                        habit.addToStreak = true
//                    }
//                    print("Cool")
//                }
//            }
        
            // Yearly
            if today.timeIntervalSinceDate(timeDate) >= (86400 * 365) {
                let results = realm.objects(Habit).filter("rawInterval = 'year'")
                for habit: Habit in results {
                    try! realm.write {
                        habit.frequency = habit.goalFrequency
                        habit.addToStreak = true
                    }
                }
            }
            
            // Monthly
            if today.timeIntervalSinceDate(timeDate) >= (86400 * 30) {
                let results = realm.objects(Habit).filter("rawInterval = 'month'")
                for habit: Habit in results {
                    try! realm.write {
                        habit.frequency = habit.goalFrequency
                        habit.addToStreak = true
                    }
                }
            }

            // Weekly
            if today.timeIntervalSinceDate(timeDate) >= 604800 {
                let results = realm.objects(Habit).filter("rawInterval = 'week'")
                for habit: Habit in results {
                    try! realm.write {
                        habit.frequency = habit.goalFrequency
                        habit.addToStreak = true
                    }
                }
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
}
