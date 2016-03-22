//
//  CreateViewController+PickerView.swift
//  Continuous
//
//  Created by Chloe on 2016-03-22.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import Foundation
import UIKit

extension CreateViewController {
    
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
    
}