//
//  SearchVC.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import UIKit

protocol SearchParameterViewController {
    var search: Search? { get set }
    var completion: ((Void) -> ())? { get set }
    func configure()
}

enum CurrentView {
    case Cities
    case CheckIn
    case CheckOut
    case Guests
}

let dates = [
    "23 June 2016",
    "24 June 2016",
    "25 June 2016",
    "26 June 2016",
    "27 June 2016",
    "28 June 2016",
    "29 June 2016",
    "30 June 2016",
    "1 July 2016",
    "2 July 2016",
    "3 July 2016",
    "4 July 2016",
    "5 July 2016",
    "6 July 2016",
    "7 July 2016",
    "8 July 2016",
    "9 July 2016",
    "10 July 2016",
    "11 July 2016",
    "12 July 2016",
    "13 July 2016",
    "14 July 2016",
    "15 July 2016",
    "16 July 2016",
    "17 July 2016",
    "18 July 2016",
    "19 July 2016",
    "20 July 2016",
    "21 July 2016",
    "22 July 2016",
    "23 July 2016",
    "24 July 2016",
    "25 July 2016",
    "26 July 2016",
    "27 July 2016",
    "28 July 2016",
    "29 July 2016",
    "30 July 2016",
    "31 July 2016",
    "1 August 2016",
    "2 August 2016",
    "3 August 2016",
    "4 August 2016",
    "5 August 2016",
    "6 August 2016",
    "7 August 2016",
    "8 August 2016",
    "9 August 2016",
    "10 August 2016",
    "11 August 2016",
    "12 August 2016",
    "13 August 2016",
    "14 August 2016",
    "15 August 2016",
    "16 August 2016",
    "17 August 2016",
    "18 August 2016",
    "19 August 2016",
    "20 August 2016",
    "21 August 2016",
    "22 August 2016",
    "23 August 2016",
    "24 August 2016",
    "25 August 2016",
    "26 August 2016",
    "27 August 2016",
    "28 August 2016",
    "29 August 2016",
    "30 August 2016"
]

class SearchVC: UIViewController {
    
    var search: Search!
    var currentView = CurrentView.Cities
    var viewControllers = [SearchParameterViewController]()
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var checkInTextField: UITextField!
    @IBOutlet weak var checkOutTextField: UITextField!
    @IBOutlet weak var guestsTextField: UITextField!
    
    @IBOutlet weak var citiesView: UIView!
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var guestsView: UIView!
    
    static func initFromStoryboard(search: Search) -> SearchVC {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        controller.search = search
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.after(when: .now() + 0.5) { [weak self] in
            self?.updateSearch()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSearch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if var searchParameterViewController = segue.destinationViewController as? SearchParameterViewController {
            viewControllers.append(searchParameterViewController)
            searchParameterViewController.search = search
            searchParameterViewController.completion = { [weak self] in
                self?.updateSearch()
            }
        }
    }
    
    @IBAction func cityTextFieldDidPressed() {
        currentView = .Cities
        showView(view: citiesView)
    }
    
    @IBAction func checkInTextFieldDidPressed() {
        currentView = .CheckIn
        showView(view: checkInView)
    }
    
    @IBAction func checkOutTextFieldDidPressed() {
        currentView = .CheckOut
        showView(view: checkOutView)
    }
    
    @IBAction func guestsTextFieldDidPressed() {
        currentView = .Guests
        showView(view: guestsView)
    }
    
    private func showView(view: UIView) {
        citiesView.isHidden = citiesView != view
        checkInView.isHidden = checkInView != view
        checkOutView.isHidden = checkOutView != view
        guestsView.isHidden = guestsView != view
        viewControllers.forEach { $0.configure() }
        updateSearch()
    }
    
    private func updateSearch() {
        update(textField: cityTextField, value: search.inspirationName, selected: currentView == .Cities)
        update(textField: checkInTextField, value: search.checkin?.simpleString, selected: currentView == .CheckIn)
        update(textField: checkOutTextField, value: search.checkout?.simpleString, selected: currentView == .CheckOut)
        update(textField: guestsTextField, value: String(search.guests), selected: currentView == .Guests)
    }
    
    private func update(textField: UITextField, value: String?, selected: Bool) {
        textField.text = value ?? textField.placeholder
        if selected {
            textField.textColor = .wAirbnbPink()
        } else {
            textField.textColor = value != nil ? .wValleyGrey() : .lightGray()
        }
        textField.font = WimduFont.Small3.font
    }
}
