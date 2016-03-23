//
//  HabitCollectionViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import RealmSwift
import UIKit

private let reuseIdentifier = "HabitCell"

class HabitCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var habitView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var results: Results<Habit>?
    var delegate: PagingProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onboarding = JSSAlertView().show(self, title: "Welcome to Continuous!",
                            text: "Swipe right to create your first habit. \n Double-tap on a habit if you've done it. \n Single-tap to view stats about that habit. \n Enjoy!",
                            buttonText: "Got it!",
                            color: UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0))
        onboarding.setTitleFont("Futura-Medium")
        onboarding.setTextFont("Futura-Medium")
        onboarding.setButtonFont("Futura-Medium")
        
        habitView.delegate = self
        habitView.dataSource = self
        self.habitView.backgroundView = UIView()
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(HabitCollectionViewController.doubleTap(_:)))
        doubleTapGesture.delaysTouchesBegan = true
        doubleTapGesture.numberOfTapsRequired = 2
        habitView.addGestureRecognizer(doubleTapGesture)
        
        flowLayout.itemSize = CGSize(width: (habitView.bounds.width / 2) - 20, height: (habitView.bounds.width / 2) - 20)
        flowLayout.headerReferenceSize = CGSize(width: habitView.bounds.width, height: 40)
    }
    
    override func viewWillAppear(animated: Bool) {
        GradientMaker.gradientBackground(habitView.backgroundView!)
        
        fetchAndReload()
        
        let notifcation = NSNotificationCenter.defaultCenter()
        notifcation.addObserver(self, selector: #selector(HabitCollectionViewController.fetchAndReload), name: "EnterForeground", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        GradientMaker.gradientBackground(habitView.backgroundView!)
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
        
        cell.nameLabel!.text = habit.name.uppercaseString
        
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
        
        if habit.addToStreak == false {
            cell.backgroundColor = UIColor(red: 248.0/255.0, green: 202.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.clearColor()
        }
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor(red: 233.0/255.0, green: 127.0/255.0, blue: 2.0/255.0, alpha: 1.0).CGColor
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
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var resusableView = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HabitHeader", forIndexPath: indexPath)
            resusableView = headerView
        }
        return resusableView
    }
    
// *************************************
// MARK: Helper methods
// *************************************
    
    func doubleTap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(habitView)
        guard let indexPath = habitView.indexPathForItemAtPoint(point) else {
            return
        }
        
        let habit = results![indexPath.row]
        
        habit.changeFrequency()
        
        let newIndexPath = NSIndexPath(forItem: results!.indexOf(habit)!, inSection: 0)
        
        habitView.performBatchUpdates({
            self.habitView.moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath)
        }, completion: { _ in
            self.habitView.reloadData()
        })
    }
    
    func fetchAndReload() {
        let sortProperties = [SortDescriptor(property: "addToStreak", ascending: false), SortDescriptor(property: "sortingIndex", ascending: true), SortDescriptor(property: "frequency", ascending: false)]
        results = try! Realm().objects(Habit).sorted(sortProperties)
        
        habitView.reloadData()
    }
}
