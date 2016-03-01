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

    convenience required init(habitName: String, habitFrequency: Int, habitInterval: Interval, date: NSDate) {
        self.init()
        name = habitName
        goalFrequency = habitFrequency
        frequency = habitFrequency
        interval = habitInterval
        sortingIndex = intervalSort[habitInterval]!
        creationDate = date
    }
}
 