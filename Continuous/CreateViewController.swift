//
//  ViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import UIKit
import RealmSwift

class CreateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var habitField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var intervalField: UITextField!
    
    var pickerOptions = ["day", "week", "month", "year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        
        habitField.delegate = self
        numberField.delegate = self
        pickerView.delegate = self
        intervalField.inputView = pickerView
        
        generateQuote()
        
        let topColor = UIColor(red: 73.0/255.0, green: 10.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 189.0/255.0, green: 21.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        let viewGradient = CAGradientLayer()
        viewGradient.colors = [topColor.CGColor, bottomColor.CGColor]
        viewGradient.frame = self.view.bounds
        self.view.layer.insertSublayer(viewGradient, atIndex: 0)
        
        
            // Create the colors
//    UIColor *topColor = [UIColor colorWithRed:144.0/255.0 green:195.0/255.0 blue:212.0/255.0 alpha:1.0];
//    UIColor *bottomColor = [UIColor colorWithRed:161.0/255.0 green:212.0/255.0 blue:144.0/255.0 alpha:1.0];
//    // Create the gradient
//    CAGradientLayer *viewGradient = [CAGradientLayer layer];
//    viewGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
//    viewGradient.frame = self.view.bounds;
//    //Add gradient to view
//    [self.view.layer insertSublayer:viewGradient atIndex:0];
    }
    
    // MARK: Button - saving to realm

    @IBAction func saveButtonPressed(sender: AnyObject) {
        let habit = createHabit()
        let realm = try! Realm()
        try! realm.write {
            realm.add(habit)
        }
    }
    
    // MARK: Pickerview methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        intervalField.text = pickerOptions[row]
    }
    
    // MARK: Helper methods
    func createHabit() -> Habit {
        let habit = Habit(habitName: habitField.text!, habitFrequency: Int(numberField.text!)!, habitInterval: Interval(rawValue: intervalField.text!)!)
        return habit
    }
}

