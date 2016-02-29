//
//  DetailViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var habit = Habit()

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       testLabel.text = habit.name
    }

}
