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
        print("Share!")
    }

    @IBAction func deleteButtonPressed(sender: AnyObject) {
        print("Delete!")
        let realm = try! Realm()
        try! realm.write {
            realm.delete(habit!)
        }
        
        delegate?.goToHabitCollection()
    }

}
