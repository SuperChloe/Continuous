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

class Habit: Object {
    
    dynamic var name: String!
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
    
    dynamic var creationDate: NSDate!
    dynamic var currentStreak = 0
    dynamic var longestStreak = 0

    convenience required init(habitName: String, habitFrequency: Int, habitInterval: Interval, date: NSDate) {
        self.init()
        name = habitName
        frequency = habitFrequency
        interval = habitInterval
        creationDate = date
    }
}
 