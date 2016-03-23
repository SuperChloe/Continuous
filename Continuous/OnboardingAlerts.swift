//
//  OnboardingAlerts.swift
//  Continuous
//
//  Created by Chloe on 2016-03-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation
import UIKit

struct OnboardingAlerts {
    
    static func showWelcome(viewController: HabitCollectionViewController) {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") {
            let onboardingWelcome = JSSAlertView().show(viewController, title: "Welcome to Continuous!",
                                                        text: "Swipe right to create your first habit.",
                                                        buttonText: "Got it!",
                                                        color: UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0))
            onboardingWelcome.setTitleFont("Futura-Medium")
            onboardingWelcome.setTextFont("Futura-Medium")
            onboardingWelcome.setButtonFont("Futura-Medium")
        }
    }
    
    static func showTapInfo(viewController: HabitCollectionViewController) {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") && viewController.results!.count == 1 {
            let onboardingFirstHabit = JSSAlertView().show(viewController,
                                                           title: "Form good habits!",
                                                           text: "Double-tap if you have done a habit. \n Single-tap to view stats about a habit.",
                                                           buttonText: "Got it!",
                                                           color: UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0))
            onboardingFirstHabit.setTitleFont("Futura-Medium")
            onboardingFirstHabit.setTextFont("Futura-Medium")
            onboardingFirstHabit.setButtonFont("Futura-Medium")
            onboardingFirstHabit.addAction(turnOffOnboarding)
        }
    }
    
    static func turnOffOnboarding() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
    }
}