//
//  CheckInViewController.swift
//  IExpendables
//
//  Created by Hani Ibrahim on 6/23/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController, SearchParameterViewController {
    
    var search: Search?
    var completion: ((Void) -> ())?
    @IBOutlet weak var pickerView: UIDatePicker! {
        didSet {
            pickerView.minimumDate = Date()
        }
    }
    
    func configure() {
        guard let checkin = search?.checkin else { return }
        pickerView.date = checkin
    }
    
    @IBAction func pickerValueChanged(picker: UIDatePicker) {
        search?.checkin = picker.date
        search?.checkout = nil
        completion?()
    }
}
