//
//  SearchVC.swift
//  IExpendables
//
//  Created by Andres Brun on 23/06/16.
//  Copyright © 2016 Andres Brun. All rights reserved.
//

import Foundation
import UIKit

class SearchVC: UIViewController {
    var search: Search?
    
    static func initFromStoryboard(search: Search) -> SearchVC {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { fatalError("Unable to instantiate a CompletedIceCreamViewController from the storyboard") }
        controller.search = search
        return controller
    }
}
