//
//  DetailViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var habit: Habit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    func swiped(sender: UISwipeGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
