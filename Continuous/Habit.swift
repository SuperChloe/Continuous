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
    
    var name: String!
    var frequency: Int!
    var interval: Interval!
    
    required init() {
        super.init()
    }
    
    init(habitName: String, habitFrequency: Int, habitInterval: Interval) {
        super.init()
        name = habitName
        frequency = habitFrequency
        interval = habitInterval
    }
}
 