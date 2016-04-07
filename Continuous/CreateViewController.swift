//
//  ViewController.swift
//  Continuous
//
//  Created by Chloe on 2016-02-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import RealmSwift
import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var habitField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var intervalField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: PagingProtocol?
    let pickerView = UIPickerView()
    
    var pickerOptions = ["day", "week", "month", "year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar()
        
        saveButton.layer.borderColor = UIColor(red: 233.0/255.0, green: 127.0/255.0, blue: 2.0/255.0, alpha: 1.0).CGColor
        
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
        pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
// *************************************
// MARK: Button - Saving to Realm
// *************************************

    @IBAction func saveButtonPressed(sender: AnyObject) {
        if (habitField.text!.isEmpty || numberField.text!.isEmpty || intervalField.text!.isEmpty) {
            showIncompleteFieldsAlerts()
        } else {
            let habit = createHabit()
            let realm = try! Realm()
            try! realm.write {
                realm.add(habit)
            }
            
            LocalPushSetup.setupLocalPushNotification(habit)
            
            delegate?.goToHabitCollection(self)
        }
    }
    
    func showIncompleteFieldsAlerts() {
        let incompleteAlert = UIAlertController(title: "Oops!", message: "Please complete all fields", preferredStyle: .Alert)
        incompleteAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(incompleteAlert, animated: true, completion: nil)
    }
    
// *************************************
// MARK: Helper methods
// *************************************
    
    func createHabit() -> Habit {
        let name = habitField.text!
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(CreateViewController.dismissInput))
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
    
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        if textField == numberField {
            return newLength <= 2
        } else if textField == habitField {
            return newLength <= 50
        }
        return true
    }
}

