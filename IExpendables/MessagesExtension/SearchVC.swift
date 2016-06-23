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
}

class SearchVC: UIViewController {
    
    var search: Search?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if var searchParameterViewController = segue.destinationViewController as? SearchParameterViewController {
            searchParameterViewController.search = search
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
}
