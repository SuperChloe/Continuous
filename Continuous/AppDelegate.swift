//
//  AppDelegate.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundDate: NSDate?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let yesAction = UIMutableUserNotificationAction()
        yesAction.identifier = "YES"
        yesAction.title = "Yes"
        yesAction.activationMode = .Background
        yesAction.authenticationRequired = false
        yesAction.destructive = false
        
        let noAction = UIMutableUserNotificationAction()
        noAction.identifier = "NO"
        noAction.title = "No"
        noAction.activationMode = .Background
        noAction.destructive = true
        
        let habitCategory = UIMutableUserNotificationCategory()
        habitCategory.identifier = "HABIT_CATEGORY"
        habitCategory.setActions([yesAction, noAction], forContext: .Default)
        habitCategory.setActions([yesAction, noAction], forContext: .Minimal)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: NSSet(array: [habitCategory]) as? Set<UIUserNotificationCategory>))
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
        backgroundDate = NSDate()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        Reset().checkReset()
        
        let notification = NSNotificationCenter.defaultCenter()
        notification.postNotificationName("EnterForeground", object: nil)
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        if identifier == "YES" {
            print("yasss")
        }
        if identifier == "NO" {
            print("noooo")
        }
        completionHandler()
    }

}

