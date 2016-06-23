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
}

class SearchVC: UIViewController {
    
    var search: Search!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSearch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if var searchParameterViewController = segue.destinationViewController as? SearchParameterViewController {
            searchParameterViewController.search = search
            searchParameterViewController.completion = { [weak self] in
                self?.updateSearch()
            }
        }
    }
    
    @IBAction func cityTextFieldDidPressed() {
        showView(view: citiesView)
    }
    
    @IBAction func checkInTextFieldDidPressed() {
        showView(view: checkInView)
    }
    
    @IBAction func checkOutTextFieldDidPressed() {
        showView(view: checkOutView)
    }
    
    @IBAction func guestsTextFieldDidPressed() {
        showView(view: guestsView)
    }
    
    private func showView(view: UIView) {
        citiesView.isHidden = citiesView != view
        checkInView.isHidden = checkInView != view
        checkOutView.isHidden = checkOutView != view
        guestsView.isHidden = guestsView != view
    }
    
    private func updateSearch() {
        update(textField: cityTextField, value: search.inspiration?.name)
        update(textField: checkInTextField, value: search.checkin?.simpleString)
        update(textField: checkOutTextField, value: search.checkout?.simpleString)
        update(textField: guestsTextField, value: String(search.guests))
    }
    
    private func update(textField: UITextField, value: String?) {
        textField.text = value ?? textField.placeholder
        textField.textColor = value != nil ? .wValleyGrey() : .lightGray()
        textField.font = WimduFont.Small3.font
    }
}
