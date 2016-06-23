//
//  OfferListVC.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import UIKit

class OfferListVC: UITableViewController {
    var search: Search?
    
    static func initFromStoryboard(search: Search) -> OfferListVC {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "OfferListVC") as? OfferListVC else { fatalError("Unable to instantiate a CompletedIceCreamViewController from the storyboard") }
        controller.search = search
        return controller
    }
}
