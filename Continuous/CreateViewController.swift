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
    }
    
    // MARK: Button - saving to realm

    @IBAction func saveButtonPressed(sender: AnyObject) {
        // Save to realm
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
    func createHabit() {
        let habit = Habit(habitName: habitField.text!, habitFrequency: Int(numberField.text!)!, habitInterval: Interval(rawValue: intervalField.text!)!)
    }
}

