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
            if habit.addToStreak == false {
                LocalPushSetup.setupLocalPushNotification(habit)
            } else if habit.addToStreak == true {
                habit.currentStreak = 0
            }
            habit.frequency = habit.goalFrequency
            habit.addToStreak = true
            habit.intervalDate = NSDate()
        }
    }
}
