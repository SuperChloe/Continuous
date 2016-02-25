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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
     //   self.collectionView!.registerClass(HabitCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.habitView.backgroundView = UIView()
        GradientMaker.gradientBackground(self.habitView.backgroundView!)

    }
    
    override func viewWillAppear(animated: Bool) {
        results = try! Realm().objects(Habit)
        habitView.reloadData()
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
        print(habit.name)
        
        cell.backgroundView = UIView()
        GradientMaker.gradientYellow(cell.backgroundView!)
        cell.label!.text = habit.name
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */


}
