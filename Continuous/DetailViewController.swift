//
//  DetailViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var habit: Habit?
    var delegate: PagingProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var longestStreakLabel: UILabel!
    @IBOutlet weak var sharebutton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GradientMaker.gradientBackground(self.view)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        let dateString = dateFormatter.stringFromDate(habit!.creationDate)
        
        
        titleLabel.text = habit?.name
        goalsLabel.text = "\(habit!.goalFrequency) times a \(habit!.interval.rawValue)"
        dateLabel.text = "started on \(dateString)"
        currentStreakLabel.text = "Current Streak: \(habit!.currentStreak)"
        longestStreakLabel.text = "Longest Streak: \(habit!.longestStreak)"
    }
    
    // MARK: Buttons
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let shareActionSheet = UIAlertController(title: "Share", message: "What would you like to share?", preferredStyle: .ActionSheet)
        shareActionSheet.addAction(UIAlertAction(title: "Goal", style: .Default, handler: { (shareActionSheet) -> Void in
            print("Goal")
        }))
        shareActionSheet.addAction(UIAlertAction(title: "Current Streak", style: .Default, handler: { (shareActionSheet) -> Void in
            print("current streak")
        }))
        shareActionSheet.addAction(UIAlertAction(title: "Longest Streak", style: .Default, handler: { (shareActionSheet) -> Void in
            print("longest streak")
        }))
        shareActionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(shareActionSheet, animated: true, completion: nil)
    }

    @IBAction func deleteButtonPressed(sender: AnyObject) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(habit!)
        }
        
        delegate?.goToHabitCollection()
    }

}
