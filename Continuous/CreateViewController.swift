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
    
    var delegate: PagingProtocol?
    let pickerView = UIPickerView()
    
    var pickerOptions = ["day", "week", "month", "year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar()
        
        habitField.delegate = self
        numberField.delegate = self
        pickerView.delegate = self
        
        setupToolbar(toolbar)
        intervalField.inputView = pickerView
        
        habitField.inputAccessoryView = toolbar
        numberField.inputAccessoryView = toolbar
        intervalField.inputAccessoryView = toolbar
        
        generateQuote()
        
        GradientMaker.gradientBackground(self.view)
    }
    
    override func viewWillAppear(animated: Bool) {
        habitField.text = ""
        numberField.text = ""
        intervalField.text = ""
    }
    
    // MARK: Button - Saving to Realm

    @IBAction func saveButtonPressed(sender: AnyObject) {
        let habit = createHabit()
        let realm = try! Realm()
        try! realm.write {
            realm.add(habit)
        }
        
        print(habit)
        
        let pushNotification = UILocalNotification()
        pushNotification.alertBody = "Did you \(habit.name) this \(habit.interval.rawValue)"
        pushNotification.alertAction = "Open"
        pushNotification.fireDate = NSDate()
        pushNotification.repeatInterval = .Minute
        pushNotification.soundName = UILocalNotificationDefaultSoundName
        pushNotification.userInfo = ["UUID" : habit.uuid]
        pushNotification.category = "HABIT_CATEGORY"
        switch habit.interval as Interval {
            case .Daily: pushNotification.repeatInterval = .Day
            case .Weekly: pushNotification.repeatInterval = .WeekOfYear
            case .Monthly: pushNotification.repeatInterval = .Month
            case .Yearly: pushNotification.repeatInterval = .Year
        }
        UIApplication.sharedApplication().scheduleLocalNotification(pushNotification)
        
        delegate?.goToHabitCollection()
        
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
        let name = habitField.text!.capitalizedString
        let freq = Int(numberField.text!)!
        let inter = Interval(rawValue: intervalField.text!)!
        let habit = Habit(habitName: name, habitFrequency: freq, habitInterval: inter, date: NSDate())
        return habit
    }
    
    func setupToolbar(toolBar: UIToolbar) {
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 233.0/255.0, green: 127.0/255.0, blue: 2.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "dismissInput")
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
    }
    
    func dismissInput() {
        if habitField.isFirstResponder() {
            habitField.resignFirstResponder()
        }
        
        if numberField.isFirstResponder() {
            numberField.resignFirstResponder()
        }
        
        if intervalField.isFirstResponder() {
            if intervalField.text!.isEmpty {
                intervalField.text = "day"
            }
            intervalField.resignFirstResponder()
        }
    }
}

