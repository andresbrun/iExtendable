//
//  CheckOutViewController.swift
//  IExpendables
//
//  Created by Hani Ibrahim on 6/23/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController, SearchParameterViewController {
    
    var search: Search?
    var completion: ((Void) -> ())?
    @IBOutlet weak var pickerView: UIDatePicker! {
        didSet {
            pickerView.minimumDate = Date()
        }
    }
    
    func configure() {
        if let checkin = search?.checkin {
            pickerView.minimumDate = checkin
        }
        
        if let checkout = search?.checkout {
            pickerView.date = checkout
        }
    }
    
    @IBAction func pickerValueChanged(picker: UIDatePicker) {
        search?.checkout = picker.date
        completion?()
    }
}
