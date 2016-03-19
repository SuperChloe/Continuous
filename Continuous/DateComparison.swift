//
//  DateComparison.swift
//  Continuous
//
//  Created by Chloe on 2016-03-19.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation

struct DateComparison {
    
    static func isSameDay(date1: NSDate, date2: NSDate) -> Bool {
        return NSCalendar.currentCalendar().isDate(date1, inSameDayAsDate: date2)
    }
    
    static func isSameWeek(date1: NSDate, date2: NSDate) -> Bool {
        return NSCalendar.currentCalendar().isDate(date1, equalToDate: date2, toUnitGranularity: .WeekOfYear)
    }
    
    static func isSameMonth(date1: NSDate, date2: NSDate) -> Bool {
        return NSCalendar.currentCalendar().isDate(date1, equalToDate: date2, toUnitGranularity: .Month)
    }
    
    static func isSameYear(date1: NSDate, date2: NSDate) -> Bool {
        return NSCalendar.currentCalendar().isDate(date1, equalToDate: date2, toUnitGranularity: .Year)
    }
    
}