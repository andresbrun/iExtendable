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
