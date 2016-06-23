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
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d MMMM yyyy", options: 0, locale: Locale(localeIdentifier: "en_GB"))
        return dateFormatter
    }()
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    func configure() {
        guard let checkin = search?.checkin else { return }
        let string = dateFormatter.string(from: checkin)
        pickerView.selectRow(dates.index(of: string)!, inComponent: 0, animated: false)
    }
}

extension CheckInViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        search?.checkin = dateFormatter.date(from: dates[row])
        search?.checkout = nil
        completion?()
    }
}
