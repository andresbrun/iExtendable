//
//  GuestsCountViewController.swift
//  IExpendables
//
//  Created by Hani Ibrahim on 6/23/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import UIKit

class GuestsCountViewController: UIViewController, SearchParameterViewController {
    
    var search: Search?
    var completion: ((Void) -> ())?
    
    func configure() { }
}

extension GuestsCountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 15
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? "\(row + 1) Guest" : "\(row + 1) Guests"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        search?.guests = row + 1
        completion?()
    }
}
