//
//  HabitCollectionViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "HabitCell"

class HabitCollectionViewController: UICollectionViewController {
    
    @IBOutlet var habitView: UICollectionView!
   // var results = [Habit]()
    var results: Results<Habit>?
    var delegate: PagingProtocol?
    var gradientView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        habitView.delegate = self
        habitView.dataSource = self
        gradientView = UIView()
        self.habitView.backgroundView = UIView()
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapGesture.delaysTouchesBegan = true
        doubleTapGesture.numberOfTapsRequired = 2
        habitView.addGestureRecognizer(doubleTapGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        fetchAndReload()
        
        let notifcation = NSNotificationCenter.defaultCenter()
        notifcation.addObserver(self, selector: "fetchAndReload", name: "EnterForeground", object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        self.habitView.backgroundView!.frame = self.view.bounds
        GradientMaker.gradientBackground(habitView.backgroundView!)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        habitView.backgroundView?.bounds.origin.y = -habitView.contentOffset.y
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results!.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> HabitCollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HabitCollectionViewCell
        let habit = results![indexPath.row]
        
        cell.backgroundView = UIView()
        GradientMaker.gradientYellow(cell.backgroundView!)
        
        cell.nameLabel!.text = habit.name
        
        if habit.frequency == 0 {
            cell.frequencyLabel!.text = "Done!"
            cell.intervalLabel!.text = "Completed \(habit.interval) goal"
        } else {
            cell.frequencyLabel!.text = String(habit.frequency)
            if habit.interval == .Daily {
                cell.intervalLabel!.text = "more times today"
            } else {
                cell.intervalLabel!.text = "more times this \(habit.interval!.rawValue)"
            }
        }
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let habit = results![indexPath.row]
        delegate?.goToDetail(habit)
    }
    
    // MARK: Helper methods
    
    func doubleTap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(habitView)
        let indexPath = habitView.indexPathForItemAtPoint(point)
        
        let habit = results![indexPath!.row]
        
        if habit.frequency == 1 && habit.addToStreak == true {
            try! Realm().write {
                habit.currentStreak = habit.currentStreak + 1
                if habit.currentStreak > habit.longestStreak {
                    habit.longestStreak = habit.currentStreak
                }
                habit.frequency = 0
                let date = Date()
//                let comp = NSDateComponents()
//                comp.day = 15
//                comp.month = 2
//                comp.year = 2016
//                date.date = NSCalendar.currentCalendar().dateFromComponents(comp)!
                habit.datesDone.insert(date, atIndex: 0)
                habit.addToStreak = false
            }
            habitView.reloadData()
            return
        }
        
        if habit.frequency == 0 {
            return
        }
        
        try! Realm().write {
            habit.frequency = habit.frequency - 1
            let date = Date()
//            let comp = NSDateComponents()
//            comp.day = 14
//            comp.month = 2
//            comp.year = 2016
//            date.date = NSCalendar.currentCalendar().dateFromComponents(comp)!
            habit.datesDone.insert(date, atIndex: 0)
        }

        habitView.reloadData()
    }
    
    func fetchAndReload() {
        let sortProperties = [SortDescriptor(property: "addToStreak", ascending: false), SortDescriptor(property: "sortingIndex", ascending: true), SortDescriptor(property: "frequency", ascending: false)]
        results = try! Realm().objects(Habit).sorted(sortProperties)
        
        habitView.reloadData()
        print("collection view reloaded")
    }
}
