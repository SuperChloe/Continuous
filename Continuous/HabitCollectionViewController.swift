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
        
        self.habitView.backgroundView!.frame = self.view.bounds
        GradientMaker.gradientBackground(habitView.backgroundView!)
        
        fetchAndReload()
        
        let notifcation = NSNotificationCenter.defaultCenter()
        notifcation.addObserver(self, selector: "fetchAndReload", name: "EnterForeground", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
//        self.habitView.backgroundView!.frame = self.view.bounds
        GradientMaker.gradientBackground(habitView.backgroundView!)
    }
    
    override func viewDidLayoutSubviews() {
        self.habitView.backgroundView!.frame = self.view.bounds
//        GradientMaker.gradientBackground(habitView.backgroundView!)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        habitView.backgroundView?.bounds.origin.y = -habitView.contentOffset.y
    }
    
// *************************************
// MARK: UICollectionViewDataSource
// *************************************
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results!.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> HabitCollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HabitCollectionViewCell
        let habit = results![indexPath.row]
        
       // cell.backgroundView = UIView()
       // GradientMaker.gradientYellow(cell.backgroundView!)
        
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
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
    
        return cell
    }
    
// *************************************
// MARK: UICollectionViewDelegate
// *************************************
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let habit = results![indexPath.row]
        delegate?.goToDetail(habit)
    }
    
// *************************************
// MARK: Helper methods
// *************************************
    
    func doubleTap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(habitView)
        let indexPath = habitView.indexPathForItemAtPoint(point)
        
        let habit = results![indexPath!.row]
        
        habit.changeFrequency()

        habitView.reloadData()
    }
    
    func fetchAndReload() {
        let sortProperties = [SortDescriptor(property: "addToStreak", ascending: false), SortDescriptor(property: "sortingIndex", ascending: true), SortDescriptor(property: "frequency", ascending: false)]
        results = try! Realm().objects(Habit).sorted(sortProperties)
        
        habitView.reloadData()
    }
}
