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
    
    var pickerOptions = ["day", "week", "month", "year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        let pickerToolbar = UIToolbar()
        
        habitField.delegate = self
        numberField.delegate = self
        pickerView.delegate = self
        
        setupPickerToolbar(pickerToolbar)
        intervalField.inputView = pickerView
        intervalField.inputAccessoryView = pickerToolbar
        
        generateQuote()
        
        GradientMaker.gradientBackground(self.view)
    }
    
    // MARK: Button - Saving to Realm

    @IBAction func saveButtonPressed(sender: AnyObject) {
        let habit = createHabit()
        let realm = try! Realm()
        try! realm.write {
            realm.add(habit)
        }
        
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
        let name = habitField.text!
        let freq = Int(numberField.text!)!
        let inter = Interval(rawValue: intervalField.text!)!
        let habit = Habit(habitName: name, habitFrequency: freq, habitInterval: inter)
        return habit
    }
    
    func setupPickerToolbar(toolBar: UIToolbar) {
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 233.0/255.0, green: 127.0/255.0, blue: 2.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "donePicker")
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
    }
    
    func donePicker() {
        intervalField.resignFirstResponder()
    }
}

