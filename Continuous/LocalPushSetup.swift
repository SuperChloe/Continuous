//
//  LocalPushSetup.swift
//  Continuous
//
//  Created by Chloe on 2016-03-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation
import UIKit

struct LocalPushSetup {
    
    static func setupLocalPushNotification(habit: Habit) {
        
        let pushNotification = UILocalNotification()
        
        pushNotification.alertBody = "Did you \(habit.name) today?"
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
        
        UIApplication.sharedApplication().scheduleLocalNotification(pushNotification)
    }

}