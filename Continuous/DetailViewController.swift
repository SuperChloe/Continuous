//
//  DetailViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar

class DetailViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    var habit: Habit?
    var delegate: PagingProtocol?
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var longestStreakLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GradientMaker.gradientBackground(self.view)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        let dateString = dateFormatter.stringFromDate(habit!.creationDate)
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.scrollDirection = .Horizontal
        calendarView.allowsMultipleSelection = true
        
        for date: Date in habit!.datesDone {
           calendarView.selectDate(date.date)
        }
        
        titleLabel.text = habit?.name.uppercaseString
        goalsLabel.text = "\(habit!.goalFrequency) times a \(habit!.interval.rawValue)"
        dateLabel.text = "started on \(dateString)"
        currentStreakLabel.text = "Current Streak: \(habit!.currentStreak)"
        longestStreakLabel.text = "Longest Streak: \(habit!.longestStreak)"
        
        shareButton.layer.borderColor = UIColor(red: 233.0/255.0, green: 127.0/255.0, blue: 2.0/255.0, alpha: 1.0).CGColor
        deleteButton.layer.borderColor = UIColor(red: 233.0/255.0, green: 127.0/255.0, blue: 2.0/255.0, alpha: 1.0).CGColor
    }
    
// *************************************
// MARK: Buttons
// *************************************
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let shareActionSheet = UIAlertController(title: "Share", message: "What would you like to share?", preferredStyle: .ActionSheet)
        
        shareActionSheet.addAction(UIAlertAction(title: "Goal", style: .Default, handler: { (shareActionSheet) -> Void in
            
            let shareString = "My goal is to \(self.habit!.name) \(self.habit!.goalFrequency) times a \(self.habit!.interval.rawValue)! - via Continuous"
            let activityViewController = UIActivityViewController(activityItems: [shareString], applicationActivities: nil)
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }))
        
        shareActionSheet.addAction(UIAlertAction(title: "Current Streak", style: .Default, handler: { (shareActionSheet) -> Void in
            
            let shareString = "Habit: \(self.habit!.name), Current Streak: \(self.habit!.currentStreak) - via Continuous"
            let activityViewController = UIActivityViewController(activityItems: [shareString], applicationActivities: nil)
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }))
        
        shareActionSheet.addAction(UIAlertAction(title: "Longest Streak", style: .Default, handler: { (shareActionSheet) -> Void in
            
            let shareString = "Habit: \(self.habit!.name), Longest Streak: \(self.habit!.longestStreak) - via Continuous"
            let activityViewController = UIActivityViewController(activityItems: [shareString], applicationActivities: nil)
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }))
        
        shareActionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(shareActionSheet, animated: true, completion: nil)
    }

    @IBAction func deleteButtonPressed(sender: AnyObject) {
        for notification: UILocalNotification in UIApplication.sharedApplication().scheduledLocalNotifications! {
            if (notification.userInfo!["UUID"] as! String == habit!.uuid) {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }

        let realm = try! Realm()
        try! realm.write {
            realm.delete(habit!)
        }
        
        delegate?.goToHabitCollection(self)
    }

}
