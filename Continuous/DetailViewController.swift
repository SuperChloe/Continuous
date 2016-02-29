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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sharebutton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GradientMaker.gradientBackground(self.view)
        
        titleLabel.text = habit?.name
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
    }

}
