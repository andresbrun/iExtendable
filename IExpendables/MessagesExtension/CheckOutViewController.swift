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
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d MMMM yyyy", options: 0, locale: Locale(localeIdentifier: "en_GB"))
        return dateFormatter
    }()
    @IBOutlet weak var pickerView: UIPickerView!
    
    func configure() {
        if let checkout = search?.checkout {
            pickerView.selectRow(dates.index(of: dateFormatter.string(from: checkout))!, inComponent: 0, animated: false)
        } else if let checkin = search?.checkin {
            pickerView.selectRow(dates.index(of: dateFormatter.string(from: checkin))!, inComponent: 0, animated: false)
        }
    }
}

extension CheckOutViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        search?.checkout = dateFormatter.date(from: dates[row])
        completion?()
    }
}
