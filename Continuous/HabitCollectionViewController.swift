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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.habitView.delegate = self
        self.habitView.dataSource = self
        self.habitView.backgroundView = UIView()
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapGesture.delaysTouchesBegan = true
        doubleTapGesture.numberOfTapsRequired = 2
        self.habitView .addGestureRecognizer(doubleTapGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        results = try! Realm().objects(Habit)
        habitView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        self.habitView.backgroundView!.frame = self.view.bounds
        GradientMaker.gradientBackground(self.habitView.backgroundView!)
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
        cell.frequencyLabel!.text = String(habit.frequency)
        cell.intervalLabel!.text = "time this \(habit.interval!.rawValue)"
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let habit = results![indexPath.row]
//        
//        try! Realm().write {
//            habit.frequency = habit.frequency - 1
//        }
//        
//        habitView.reloadData()
        print("did select item at index path")
    }
    
    // MARK: Helper methods
    
    func doubleTap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(habitView)
        let indexPath = habitView.indexPathForItemAtPoint(point)
        
        let habit = results![indexPath!.row]
        
        try! Realm().write {
            habit.frequency = habit.frequency - 1
        }
        habitView.reloadData()
    }
}
